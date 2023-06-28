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
    
    func kakaoLogin() {
        
        willStartLoading()
        
        userAuthManager.requestKakaoLogin { [unowned self] error in
            if let keychainError = error as? KeychainError {
                // 알럿 -> 키체인 에러 (사용자: 토큰 저장 실패)
                self.showAlert(title: "로그인 실패")
            } else if let kakaoAuthError = error as? KakaoAuthError {
                // 알럿 -> 키체인 에러
                self.showAlert(title: "로그인에 실패했습니다.")
            }
            self.didFinishLoading()
        }

    }
    
    func getLoginSession() {
        print("DEBUG: \(#function) 로그인 세션을 가져옵니다.")
        print("DEBUG: 상태 -> 로그인 상태: \(userAuthManager.isSingIn), 유저데이터: \(userAuthManager.userData), UserID: \(userAuthManager.getId())")
        userAuthManager.getLoginSession { [weak self] error in
            print("DEBUG: \(#function) 로그인 세션 가져오기 완료.")
            if let error = error as? KakaoAuthError {
                print("DEBUG: \(#function) \(error.localizedDescription)")
                self?.userAuthManager.logout()
                return
            }
        }
        
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
