//
//  SignViewModel.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/31.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

class SignViewModel: BaseViewModel {
    
    
    func canOpen(_ url: URL) {
        if AuthApi.isKakaoTalkLoginUrl(url) {
            if AuthController.handleOpenUrl(url: url) {
                // Toast message : "open"
            }
        } else {
            // Toast message : "don't open"
        }
    }
    
    func requestKakaoLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if let error = error {
                    self?.showAlert(title: error.localizedDescription)
                } else {
                    if let token = oauthToken?.accessToken {
                        self?.showAlert(title: "\(token)")
                    } else {
                        self?.showAlert(title: "토큰없다.")
                    }
                }
            }
        }
    }
    
}
