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
    
    private var authManager = AuthManager.shared
    
    private var networkService = NetworkService()
    
    init() {
        super.init()
        loadUserProfile()
    }
    
}

extension ProfileEditViewModel {
    
    // 로그아웃
    func logout() {
        authManager.logout()
    }
    
    // 프로필 로드
    func loadUserProfile() {
        
        if let userData = authManager.userData {
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
                    error.printAndTypeCatch()
                    self?.showAlert(title: "프로필 이미지 로드 실패")
                }
            }
        } else {
            self.showAlert(title: "프로필 로드 실패")
        }
        
    }
    
    // 프로필 수정
    func editUserProfile() {
        
        let currentImageUrl = profileImageUrl
        let updatedName = nickname
        
        self.willStartLoading()

        uploadImage { [weak self] imageUrl in
            guard let self = self else { return }
            
            let body: [String: Any]? = try? UserProfileUpdateDao(nickname: updatedName,
                                                               imageUrl: imageUrl.absoluteString).toDictionary()
            
            guard let parameters = body else {return}
            guard let userdata  = authManager.userData else { return }
            
            let endpoint = "account/\(userdata.id)"
            
            networkService.PUT(headerType: .test,
                               urlType: .test,
                               endPoint: endpoint,
                               parameters: parameters,
                               returnType: UserProfileUpdateDaoResponse.self)
            .map(\.detail)
            .sink { result in
                switch result {
                case .failure(let error):
                    error.printAndTypeCatch()
                    return
                case .finished:
                    self.loadUserProfile()
                }
            } receiveValue: { updatedData in
                let data = UserData(id: userdata.id,
                                    email: userdata.email,
                                    nickName: updatedData.nickname,
                                    profileImageUrl: updatedData.imageUrl,
                                    signInProvider: userdata.signInProvider)

                self.authManager.setUserData(data)
                self.deleteOldImage(urlString: currentImageUrl)
                self.didFinishLoading()
            }
            .store(in: &cancellables)
        }
        
    }
    
    // URL -> Image
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
    
    // Firebase Image Delete
    private func deleteOldImage(urlString: String) {
        FirebaseStorageManager.deleteImage(urlString: urlString) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                error.printAndTypeCatch()
                return
            }
        }
    }
    
}
