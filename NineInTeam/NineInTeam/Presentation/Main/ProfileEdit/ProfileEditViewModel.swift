//
//  ProfileEditViewModel.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/29.
//

import SwiftUI

class ProfileEditViewModel: BaseViewModel {
    
    private var credentialManager = UserAuthManager.shared
    
    @Published var nickname: String = ""
    @Published var email: String = ""
    @Published var profileImage: UIImage?
    
    func getProfileData() {
        
        if let userData = credentialManager.userData {
            print("프로필 가져오기: \(userData)")
            self.email = userData.email
            self.nickname = userData.nickName
            getImageData(url: userData.profileImageUrl) { [weak self] image in
                DispatchQueue.main.async {
                    self?.profileImage = image
                }
            }
        } else {
            print("프로필 없음")
        }
        
    }
    
    func getImageData(url: String, completion: @escaping(UIImage?) -> Void) {
        
        if let url = URL(string: url) {
            // TODO: 이미지 가져오는 작업 어떻게 해야 효율적일지 확인해서 작업
            // TODO: 로그인 작업 구조화
                URLSession.shared.dataTask(with: url) { data, _, error in
                    if error != nil {
                        completion(nil)
                    }
                    
                    if let data = data {
                        return completion(UIImage(data: data))
                    }
                }
                .resume()
        } else {
            completion(nil)
        }
    }
    
}
