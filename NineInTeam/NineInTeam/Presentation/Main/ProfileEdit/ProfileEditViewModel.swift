//
//  ProfileEditViewModel.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/29.
//

import SwiftUI
import FirebaseStorage

final class ProfileEditViewModel: BaseViewModel {
    
    @Published var nickname: String = ""
    @Published var email: String = ""
    @Published var profileImage: UIImage?
    private var profileImageUrl: String = ""
    private var userAuthManager = UserAuthManager.shared
    private var networkService = NetworkService()
    
    override init() {
        super.init()
        getProfileData()
    }
    
}

extension ProfileEditViewModel {
    
    func logout() {
        userAuthManager.logout()
    }
    
    func getProfileData() {
        if let userData = userAuthManager.userData {
            self.email = userData.email
            self.nickname = userData.nickName
            self.profileImageUrl = userData.profileImageUrl
            
            guard let imageUrl = URL(string: userData.profileImageUrl) else { return }
            
            loadImageData(urlString: imageUrl.absoluteString) { [weak self] result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.profileImage = image
                    }
                case .failure(let error):
                    error.printAndTypeCatch(location: "getProfileData")
                    self?.showAlert(title: "프로필 이미지 로드 실패")
                }
            }
        } else {
            self.showAlert(title: "프로필 로드 실패")
        }
    }
    
    func editUserData() {
        let currentImageUrl = profileImageUrl
        let updatedName = nickname
        
        self.willStartLoading()
        // 이미지 업로드
        uploadImage { [weak self] imageUrl in
            guard let self = self else { return }
            
            let parameters: [String: Any] = [
                "nickname": updatedName,
                "imageId": imageUrl.absoluteString
            ]
            
            guard let userdata  = userAuthManager.userData else { return }
            
            let endpoint = "account/\(userdata.id)"
            
            networkService.PUT(headerType: .test,
                               urlType: .testDomain,
                               endPoint: endpoint,
                               parameters: parameters,
                               returnType: UserUpdateResponse.self)
            .map(\.detail)
            .sink { result in
                switch result {
                case .failure(let error):
                    error.printAndTypeCatch(location: "editUserData2")
                    return
                case .finished:
                    print("완료")
                    self.getProfileData()
                }
            } receiveValue: { updatedData in
                let data = UserData(id: userdata.id,
                                    email: userdata.email,
                                    nickName: updatedData.nickname,
                                    profileImageUrl: updatedData.imageUrl,
                                    loginService: userdata.loginService)
                print("DEBUG FINISHED DATA: \(data)")
                self.userAuthManager.setUserData(data)
                self.deleteOldImage(urlString: currentImageUrl)
                self.didFinishLoading()
            }
            .store(in: &cancellables)
        }
    }
    
    private func loadImageData(urlString: String,
                               completion: @escaping(Result<UIImage, Error>) -> Void) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(UIImage(data: data) ?? UIImage()))
                }
            }
            .resume()
        }
    }
    
    // Firebase Image Upload
    private func uploadImage(completion: @escaping (URL) -> Void) {
        willStartLoading()
        
        let data = self.profileImage?.pngData()
        if let data = data {
            let folder = "ProfileImage"
            let imageName = UUID().uuidString + String(Date().timeIntervalSince1970)
            let path = "\(folder)/\(imageName)"
            
            FirebaseStorageManager.uploadImage(imageData: data,
                                               path: path) { [weak self] url, error in
                if error != nil {
                    self?.showToast(title: "이미지 업로드를 실패했습니다.")
                }
                
                if let url = url {
                    completion(url)
                }
                self?.didFinishLoading()
            }
        } else {
            self.showToast(title: "이미지 변환에 실패했습니다.")
            self.didFinishLoading()
            return
        }
    }
    
    // Firebase 업로드 성공 시 기존 이미지 삭제
    private func deleteOldImage(urlString: String) {
        print("⚠️ (DEBUG) 이미지 삭제 시작")
        FirebaseStorageManager.deleteImage(urlString: urlString) { result in
            switch result {
            case .success(_):
                print("FB 이미지 삭제 완료")
            case .failure(let error):
                error.printAndTypeCatch(location: "DELETE OLD IMAGE")
                return
            }
        }
    }

    
}
