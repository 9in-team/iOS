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
    
    init(with networkService: NetworkService, authManager: AuthManager = .shared) {
        print("DEBUG INIT: KakaoAuthService")
        self.cancellables = .init()
        self.networkService = networkService
        self.authManager = authManager
    }
    
    deinit {
        print("DEBUG Deinit: KakaoSignService")
    }
    
}

// MARK: - Public Methods
extension KakaoAuthService {
    
    func requestLogin(completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.cancel()

        UserApi.shared.loginWithKakaoAccount { token, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let token = token else {
                completion(.failure(KakaoAuthError.tokenIsNil))
                return
            }
            
            self.requestSignInSession(with: token) { error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                } else {
                    completion(.success(()))
                }
            }
        }
    }

    // 기존 토큰으로 자동로그인
    func getLoginSession(completion: @escaping (Error?) -> Void) {
        do {
            let token = try fetchKakaoLoginToken()
            requestSession(with: token, completion: completion)
            return
        } catch {
            completion(error)
            return
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
    private func requestSignInSession(with oauthToken: OAuthToken, completion: @escaping (Error?) -> Void) {
        let accessToken = oauthToken.accessToken
        do {
            try KeychainManager.shared.saveToken(accessToken, signInProvider: .kakao, tokenType: .accessToken)
            requestSession(with: accessToken, completion: completion)
        } catch {
            completion(error)
        }
    }
    
    // 카카오 로그인
    private func requestSession(with accessToken: String,
                                completion: @escaping (KakaoAuthError?) -> Void) {
        networkService.cancel()
        
        let parameters = ["accessToken": accessToken]
        
        self.networkService.POST(headerType: HeaderType.test,
                                 urlType: UrlType.test,
                                 endPoint: EndPoint.loginWithKakao.get(),
                                 parameters: parameters,
                                 returnType: SignInResponseData.self)
        .sink { result in
            switch result {
            case .failure(let error):
                self.requestSessionFailureHandler(error: error, completion: completion)
            case .finished:
                completion(nil)
            }
        } receiveValue: { [weak self] responseData in
            if let responseData = responseData.detail {
                let userData = UserData(id: responseData.id,
                                        email: responseData.email,
                                        nickName: responseData.nickname,
                                        profileImageUrl: responseData.imageUrl,
                                        signInProvider: .kakao)
                self?.authManager.userData = userData
                self?.authManager.isSingIn = true
                self?.authManager.lastSignInProvider = .kakao
            } else {
                self?.authManager.logout()
                completion(KakaoAuthError.userdataFetchFailure)
            }
        }.store(in: &self.cancellables)

    }
    
    private func requestSessionFailureHandler(error: Error, completion: @escaping (KakaoAuthError?) -> Void) {
        if self.authManager.isSingIn == true {
            self.authManager.logout()
            print("DEBUG: \(#function) \(error.localizedDescription)")
            completion(KakaoAuthError.sessionExpired)
        } else {
            completion(KakaoAuthError.unknown)
        }
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
