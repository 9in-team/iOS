//
//  SignViewModel.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/31.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class SignViewModel: BaseViewModel {
    
    private var service: NetworkProtocol
    
    private var userAuthManager = UserAuthManager.shared
    
    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
        super.init()
    }
    
    func autoLogin() {
        // [테스트용] UserDefaults 에서 애플, 카카오 로그인 데이터 가져오기
        userAuthManager.isSingIn = true
    }
    
    func requestKakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                self?.kakaoLoginClosure(oauthToken: oauthToken, error: error)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                self?.kakaoLoginClosure(oauthToken: oauthToken, error: error)
            }
        }
    }
    
    // 카카오 로그인 클로저
    private func kakaoLoginClosure(oauthToken: OAuthToken?, error: Error?) {
        if let error = error {
            showAlert(title: error.localizedDescription)
        } else {
            if let accessToken = oauthToken?.accessToken {
                KeychainManager.shared.saveLoginToken(token: accessToken)
                kakaoLogin(accessToken: accessToken)
            } else {
                showAlert(title: "토큰을 가져오지 못했습니다.")
            }
        }
        
    }
    
    // 카카오 로그인
    func kakaoLogin(accessToken: String) {
        let parameters = ["accessToken": accessToken]
        
        willStartLoading()
        
        service.POST(headerType: HeaderType.test,
                     urlType: UrlType.testDomain,
                     endPoint: EndPoint.login.get(),
                     parameters: parameters,
                     returnType: UserDataApiResponse.self)
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    if self?.userAuthManager.isSingIn == true {
                        self?.userAuthManager.logout()
                        self?.showAlert(title: "다시 로그인 해주세요.")
                    } else {
                        self?.showAlert(title: "로그인에 실패했습니다.")
                    }
                case .finished:
                    break
                }
                self?.didFinishLoading()
                
            } receiveValue: { [weak self] responseData in
                if let responseData = responseData.detail {

                    let userData = UserData(id: responseData.id,
                                            email: responseData.email,
                                            nickName: responseData.nickname,
                                            profileImageUrl: responseData.imageUrl,
                                            signInProvider: .kakao)
                    
                    self?.userAuthManager.userData = userData
                    self?.userAuthManager.isSingIn = true
                    
                } else {
                    return
                }
                
            }
            .store(in: &cancellables)
        
    }
    
    // 기존 토큰으로 자동로그인
    func getLoginSession() {
        self.kakaoLogin(accessToken: userAuthManager.fetchKakaoLoginToken())
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
                     returnType: UserDataApiResponse.self)
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
