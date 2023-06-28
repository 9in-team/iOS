//
//  UserAuthManager.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/18.
//

import SwiftUI
import Combine
import KakaoSDKUser
import KakaoSDKAuth

class UserAuthManager: ObservableObject {
    
    private var keychainManager = KeychainManager.shared
    private var networkService = NetworkService()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userData: UserData?
    
    @AppStorage("isSignIn") var isSingIn = false
    
    static let shared = UserAuthManager()
    
    private init() { }
    
}

extension UserAuthManager {
    func fetchKakaoLoginToken() throws -> String {
        do {
            return try KeychainManager.shared.getToken(signInProvider: .kakao, tokenType: .accessToken)
        } catch {
            throw error
        }
    }
    
    func logout(signInProvider: SignInProviderType = .kakao) {
        self.isSingIn = false
        self.userData = nil
        self.keychainManager.deleteToken(signInProvider: signInProvider)
        UserApi.shared.logout { error in
            if let error = error {
                print("DEBUG: 카카오 로그아웃 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func getId() -> Int? {
        if let userData = userData {
            return userData.id
        } else {
            return nil
        }
    }
    
    func setUserData(_ data: UserData) {
        self.userData = data
    }
    
}

// 카카오 로그인 로직
extension UserAuthManager {
    
    func requestKakaoLogin(completion: @escaping (Error?) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                do {
                    if let error = error {
                        print("DEBUG: \(#function) \(error.localizedDescription)")
                        completion(error)
                    }
                    try self?.requestKakaoSession(oauthToken: oauthToken)
                    completion(nil)
                } catch {
                    completion(error)
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                do {
                    if let error = error {
                        completion(error)
                    }
                    try self?.requestKakaoSession(oauthToken: oauthToken)
                    completion(nil)
                } catch {
                    completion(error)
                }
            }
        }
    }

    /// 토큰을 통해 로그인 세션 요청
    /// - 에러처리: KakaoAuthError or KeychainError
    private func requestKakaoSession(oauthToken: OAuthToken?) throws {
        if let accessToken = oauthToken?.accessToken {
            do {
                try KeychainManager.shared.saveToken(accessToken, signInProvider: .kakao, tokenType: .accessToken)
                print("✅ DEBUG: 토큰 저장 성공! ( kakaoLoginClosure )")
                var loginError: KakaoAuthError?
                kakaoLogin(accessToken: accessToken) { error in
                    if let error = error {
                        loginError = error
                    }
                }
                
                if let loginError = loginError {
                    print("❗️DEBUG: \(#function) \(loginError.localizedDescription)")
                    throw loginError
                }
                
            } catch {
                print("❗️DEBUG: \(#function) \(error.localizedDescription)")
                throw error
            }
        } else {
            throw KakaoAuthError.tokenIsNil
        }
    }
    
    // 카카오 로그인
    private func kakaoLogin(accessToken: String, completion: @escaping (KakaoAuthError?) -> Void) {
        
        print("DEBUG: 카카오 로그인을 요청합니다.")
        
        let parameters = ["accessToken": accessToken]
        
        networkService.POST(headerType: HeaderType.test,
                            urlType: UrlType.testDomain,
                            endPoint: EndPoint.login.get(),
                            parameters: parameters,
                            returnType: UserDataApiResponse.self)
            .sink { [weak self] result in
                switch result {
                case .failure(let error):
                    if self?.isSingIn == true {
                        self?.logout()
                        print(error.localizedDescription)
                        completion(KakaoAuthError.sessionExpired)
                    } else {
                        completion(KakaoAuthError.unknown)
                    }
                case .finished:
                    break
                }
            } receiveValue: { [weak self] responseData in
                if let responseData = responseData.detail {
                    let userData = UserData(id: responseData.id,
                                            email: responseData.email,
                                            nickName: responseData.nickname,
                                            profileImageUrl: responseData.imageUrl,
                                            signInProvider: .kakao)
                    self?.userData = userData
                    self?.isSingIn = true
                    completion(nil)
                } else {
                    self?.logout(signInProvider: .kakao)
                    completion(KakaoAuthError.userdataFetchFailure)
                }
            }
            .store(in: &cancellables)
    }
    
    // 기존 토큰으로 자동로그인
    func getLoginSession(completion: @escaping (Error?) -> Void) {
        do {
            print("DEBUG: 세션을 가져옵니다.")
            self.kakaoLogin(accessToken: try fetchKakaoLoginToken()) { error in
                if let error = error {
                    print("DEBUG: 카카오 로그인 에러발생 \(error.localizedDescription)")
                    completion(error)
                }
                print("DEBUG: 로그인 성공.")
                completion(nil)
            }
        } catch {
            print("DEBUG: \(#function) \(error.localizedDescription)")
            completion(error)
        }
    }

}

// Test Stub
extension UserAuthManager {
    
    func testLogin(accesstoken: String, completion: @escaping (Error?) -> Void) {
        self.kakaoLogin(accessToken: accesstoken) { error in
            completion(error)
        }
    }
    
}
