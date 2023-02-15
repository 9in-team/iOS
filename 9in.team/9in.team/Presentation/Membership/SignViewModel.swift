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
    
    var service: NetworkProtocol
    
    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
        super.init()
    }
    
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
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if let error = error {
                    self?.showAlert(title: error.localizedDescription)
                } else {
                    if let accessToken = oauthToken?.accessToken {
                        self?.login(accessToken: accessToken)
//                        self?.requestUserDataForJoin()
                    } else {
                        self?.showAlert(title: "토큰을 가져오지 못했습니다.")
                    }
                }
            }
        }
    }
    
    // 로그인
    func login(accessToken: String) {
        let parameters = ["kakaoAccessToken": accessToken]
        
        willStartLoading()
        service.POST(headerType: HeaderType.test,
                     urlType: UrlType.test,
                     endPoint: EndPoint.login.get(),
                     parameters: parameters,
                     returnType: BaseResponseModel.self)
            .sink { [weak self] completion in
                guard let self = self else {
                    return
                }
                
                switch completion {
                case .failure(let error):
                    self.showToast(title: "에러가 발생했어요.\n\(error)")
                case .finished:
                    self.showAlert(title: "로그인 성공!")
                }
                self.didFinishLoading()
            } receiveValue: { [weak self] _ in
                guard self != nil else {
                    return
                }
            }
            .store(in: &cancellables)
    }
    
    // 회원가입
    func join(email: String, nickname: String, imageUrl: String = "") {
        var parameters = ["email": email,
                          "nickname": nickname]
        if !imageUrl.isEmpty {
            parameters["imageId"] = imageUrl
        }
        
        willStartLoading()
        service.POST(headerType: HeaderType.test,
                     urlType: UrlType.test,
                     endPoint: EndPoint.join.get(),
                     parameters: parameters,
                     returnType: BaseResponseModel.self)
            .sink { [weak self] completion in
                guard let self = self else {
                    return
                }
                
                switch completion {
                case .failure(let error):
                    self.showToast(title: "에러가 발생했어요.\n\(error)")
                case .finished:
                    break
                }
                self.didFinishLoading()
            } receiveValue: { [weak self] _ in
                guard self != nil else {
                    return
                }
            }
            .store(in: &cancellables)
    }
    
    func requestUserDataForJoin() {
        UserApi.shared.me { [weak self] (user, error) in
            if let error = error {
                self?.showAlert(title: error.localizedDescription)
            } else {
                guard let email = user?.kakaoAccount?.email else {
                    self?.showAlert(title: "카카오톡 회원정보를 가져오지 못했습니다.")
                    return
                }
                
                guard let nickname = user?.kakaoAccount?.profile?.nickname else {
                    self?.showAlert(title: "카카오톡 회원정보를 가져오지 못했습니다.")
                    return
                }
                
                if let imageUrl = user?.kakaoAccount?.profile?.profileImageUrl {
                    self?.join(email: email, nickname: nickname, imageUrl: imageUrl.absoluteString)
                } else {
                    self?.join(email: email, nickname: nickname)
                }
            }
        }
    }
    
}
