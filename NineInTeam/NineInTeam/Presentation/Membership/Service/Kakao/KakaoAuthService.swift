//
//  KakaoAuthService.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/30.
//

import SwiftUI
import Combine
import KakaoSDKUser
import KakaoSDKAuth

// 카카오 로그인 로직
class KakaoAuthService {
    
    private var authManager: AuthManager
    private var networkService: NetworkService
    private var cancellables = Set<AnyCancellable>()
    
    init(authManager: AuthManager = AuthManager.shared, networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
        self.authManager = authManager
    }
    
    deinit {
        print("Deinit: KakaoSignService")
    }
    
}

// MARK: - Public Methods
extension KakaoAuthService {
    
    func requestLogin(completion: @escaping (Error?) -> Void) {
        UserApi.shared.loginWithKakaoAccount { oauthToken, error in
            do {
                if let error = error {
                    completion(error)
                }
                
                try self.requestSignInSession(with: oauthToken)
                
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    // 기존 토큰으로 자동로그인
    func getLoginSession(completion: @escaping (Error?) -> Void) {
        do {
            self.requestSession(with: try fetchKakaoLoginToken()) { error in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }
        } catch {
            completion(error)
        }
    }
    
    func kakaoLogout() {
        UserApi.shared.logout { error in
            if let error = error {
                print("DEBUG: 카카오 로그아웃 실패: \(error.localizedDescription)")
            }
            return
        }
    }
    
}

// MARK: - Private Methods (Login Logic)
extension KakaoAuthService {
    
    /// 토큰을 통해 로그인 세션 요청
    /// - 에러처리: KakaoAuthError or KeychainError
    private func requestSignInSession(with oauthToken: OAuthToken?) throws {
        
        if let accessToken = oauthToken?.accessToken {
            do {
                try KeychainManager.shared.saveToken(accessToken, signInProvider: .kakao, tokenType: .accessToken)
                
                var loginError: KakaoAuthError?
                
                requestSession(with: accessToken) { error in
                    if let error = error {
                        loginError = error
                    }
                }
                
                if let loginError = loginError {
                    throw loginError
                }
                
            } catch {
                throw error
            }
        } else {
            throw KakaoAuthError.tokenIsNil
        }
    }
    
    // 카카오 로그인
    private func requestSession(with accessToken: String, completion: @escaping (KakaoAuthError?) -> Void) {
        
        let parameters = ["accessToken": accessToken]
        
        networkService.POST(headerType: HeaderType.test,
                            urlType: UrlType.testDomain,
                            endPoint: EndPoint.login.get(),
                            parameters: parameters,
                            returnType: KakaoUserDataResponse.self)
        .sink { [weak self] result in
            switch result {
            case .failure(let error):
                if self?.authManager.isSingIn == true {
                    self?.authManager.logout()
                    print("DEBUG: \(#function) \(error.localizedDescription)")
                    completion(KakaoAuthError.sessionExpired)
                } else {
                    completion(KakaoAuthError.unknown)
                }
            case .finished:
                break
            }
        } receiveValue: { responseData in
            if let responseData = responseData.detail {
                let userData = UserData(id: responseData.id,
                                        email: responseData.email,
                                        nickName: responseData.nickname,
                                        profileImageUrl: responseData.imageUrl,
                                        signInProvider: .kakao)
                self.authManager.userData = userData
                self.authManager.isSingIn = true
                self.authManager.lastSignInProvider = .kakao
                completion(nil)
            } else {
                self.authManager.logout()
                completion(KakaoAuthError.userdataFetchFailure)
            }
        }
        .store(in: &cancellables)
    }
    
    private func fetchKakaoLoginToken() throws -> String {
        do {
            return try KeychainManager.shared.getToken(signInProvider: .kakao, tokenType: .accessToken)
        } catch {
            throw error
        }
    }
    
}

// Test Stub
#if canImport(XCTest)
extension KakaoAuthService {
    
    func setAuthManager(_ authManager: AuthManager) {
        self.authManager = authManager
    }
    
    func testLogin(accesstoken: String, completion: @escaping (Error?) -> Void) {
        self.requestSession(with: accesstoken, completion: completion)
    }
    
}
#endif
