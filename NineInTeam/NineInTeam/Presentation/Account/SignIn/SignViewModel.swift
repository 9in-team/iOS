//
//  SignViewModel.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/31.
//

import UIKit
import AuthenticationServices
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

final class SignViewModel: BaseViewModel {
    
    private var networkService: NetworkProtocol
    
    private var authManager = AuthenticationManager.shared
    
    init(service: NetworkProtocol = NetworkService()) {
        self.networkService = service
        super.init()
    }
    
}

// MARK: - Apple Login

extension SignViewModel {
    
    func appleSignInOnRequest(_ request: ASAuthorizationAppleIDRequest) {
        willStartLoading()
        request.requestedScopes = [.fullName, .email]
    }
    
    func appleLogin(_ authResult: Result<ASAuthorization, Error>) {
        do {
            try authManager.appleLogin(authResult: authResult)
            self.didFinishLoading()

        } catch {
            print("DEBUG: AppleLogin ERROR \(error)")
            self.didFinishLoading()
        }
    }
    
    func getAppleSignInSession() {
        authManager.getSession { _ in
            // 서버측 구현 완료시 id 값을 받아서 사용자데이터 가져오기 Request 구현 필요.
        }
    }
    
}

// MARK: - Kakao Login
extension SignViewModel {
    
    // [테스트용] UserDefaults 에서 애플, 카카오 로그인 데이터 가져오기
    func autoLogin() {
        authManager.isSingIn = true
    }
    
    // 카카오 로그인
    func kakaoLogin() {
        willStartLoading()
        
        authManager.login(provider: .kakao) { [weak self] error in
            if let error = error {
                self?.showAlert(title: "로그인에 실패했어요. \(error.localizedDescription)")
                self?.didFinishLoading()
            }
        }
    }
    
    // 카카오 로그인 (기존세션)
    func kakaoLoginWithSession(completion: @escaping (Error?) -> Void) {
        authManager.getSession { error in
            if let error = error {
                self.loginErrorPrinter(error)
                self.authManager.logout()
                completion(error)
                return
            }
        }
    }
}

extension SignViewModel {
    
    // 회원가입
    func join(email: String, nickname: String, imageUrl: String = "") {
        var parameters = ["email": email,
                          "nickname": nickname]
        if !imageUrl.isEmpty {
            parameters["imageId"] = imageUrl
        }        
        
        willStartLoading()
        
        networkService.POST(headerType: HeaderType.test,
                     urlType: UrlType.test,
                     endPoint: EndPoint.join.get(),
                     parameters: parameters,
                     returnType: SignInResponse.self)
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
    
    private func requestUserDataForJoin() {
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
    
    private func loginErrorPrinter(_ error: Error, sender: String = #function) {
        if let keychainError = error as? KeychainError {
            print("DEBUG: \(sender) message: \(error.localizedDescription)")
        } else if let kakaoAuthError = error as? KakaoAuthError {
            print("DEBUG: \(sender) message: \(error.localizedDescription)")
        } else {
            print("DEBUG: \(sender) message: \(error.localizedDescription)")
        }
    }

}
