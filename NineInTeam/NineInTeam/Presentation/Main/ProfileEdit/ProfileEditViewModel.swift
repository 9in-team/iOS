//
//  ProfileEditViewModel.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/29.
//

import SwiftUI
import FirebaseStorage

class ProfileEditViewModel: BaseViewModel {
    
    private var credentialManager = UserAuthManager.shared
    
    @Published var nickname: String = ""
    @Published var email: String = ""
    @Published var profileImageUrl: String = ""
    @Published var profileImage: UIImage?
    
    func getProfileData() {
        
        if let userData = credentialManager.userData {
            print("프로필 가져오기: \(userData)")
            self.email = userData.email
            self.nickname = userData.nickName
            self.profileImageUrl = userData.profileImageUrl
            getImageData(url: profileImageUrl) { [weak self] image in
                DispatchQueue.main.async {
                    self?.profileImage = image
                }
            }
        } else {
            print("프로필 없음")
        }
    }
    
    func getImageData(url: String, completion: @escaping(UIImage) -> Void) {
        let errorImage = UIImage(named: "Send")!
        
        // TODO: 실 운영시 server에 userimage url 요청
        if let url = URL(string: url) {
            
            // TODO: 이미지 가져오는 작업 어떻게 해야 효율적일지 확인해서 작업
            // [] URL 받아서 Image로 변경하기. -> 가능하면 이미지 캐시하기.
            // [] 뷰에 표시할 때 백엔드 서버에서 불러오기.
            // [] 변경 시 사진 서버에 올리고, 뷰 업데이트하기.
            URLSession.shared.dataTask(with: url) { data, _, error in
                if error != nil {
                    completion(errorImage)
                }
                if let data = data {
                    print("이미지전달완료")
                    completion(UIImage(data: data) ?? errorImage)
                } else {
                    completion(errorImage)
                }
            }.resume()
            
        } else {
            completion(errorImage)
        }
    }
    
    // Firebase Image Upload
    func uploadImage(completion: @escaping (URL) -> Void) {
        willStartLoading()
        
        let data = self.profileImage?.pngData()
        if let data = data {
            let folder = "ProfileImage"
            let imageName = UUID().uuidString + String(Date().timeIntervalSince1970)
            let path = "\(folder)/\(imageName)"
            
            FirebaseStorageManager.uploadImage(imageData: data, path: path) { [weak self] url, error in
                if error != nil {
                    self?.showToast(title: "이미지 업로드를 실패했습니다.")
                } else {
                    completion(url!)
                }
                self?.didFinishLoading()
            }
        } else {
            self.showToast(title: "이미지 변환에 실패했습니다.")
            self.didFinishLoading()
            return
        }
    }
    
}
