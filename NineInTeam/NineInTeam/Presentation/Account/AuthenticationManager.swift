//
//  AuthenticationManager.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/18.
//

import SwiftUI
import Combine
import KakaoSDKUser
import KakaoSDKAuth
import AuthenticationServices

class AuthenticationManager: ObservableObject {
    
    private var keychainManager = KeychainManager.shared
    private var networkService: NetworkService
    private var cancellables = Set<AnyCancellable>()
    
    @AppStorage("lastSignProvider") var lastSignInProvider: SignInProviderType = .notSigned
    @AppStorage("isSignIn") var isSingIn = false
    @Published var userData: UserData?
    
    static let shared = AuthenticationManager()
    
    private init() {
        self.networkService = NetworkService()
    }

}

extension AuthenticationManager {
    
    func login(provider: SignInProviderType, completion: @escaping (Error?) -> Void) {
        switch provider {
        case .kakao:
            KakaoAuthService(with: networkService)
                .requestLogin { result in
                    switch result {
                    case .success(_):
                        completion(nil)
                    case .failure(let error):
                        completion(error)
                    }
                }
        default:
            completion(SignInError.notSigned)
        }
    }
    
    func appleLogin(provider: SignInProviderType = .apple, authResult: Result<ASAuthorization, Error>) throws {
        switch authResult {
        case .success(let authorization):
            do {
                try AppleAuthService(with: networkService).signIn(with: authorization)
            } catch {
                throw error
            }
        case .failure(let error):
            throw error
        }

    }
    
    func getSession(completion: @escaping (Error?) -> Void) {
        
        print("로그인 세션 가져오기")
        switch lastSignInProvider {
        case .kakao:
            KakaoAuthService(with: networkService).getLoginSession(completion: completion)
        case .apple:
            do {
                try AppleAuthService(with: networkService).getSignedSession()
            } catch {
                print(error)
                completion(error)
            }
        default:
            completion(SignInError.unknownSession)
        }
    }
    
    func logout() {
        self.isSingIn = false
        self.userData = nil
        
        self.keychainManager.deleteToken(signInProvider: lastSignInProvider)
        
        switch lastSignInProvider {
        case .kakao:
            KakaoAuthService(with: networkService).kakaoLogout()
        default:
            return
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
    
    func accountDeletion() {
        
    }
    
}

// 카카오 로그인 Test Stub
#if canImport(XCTest)
extension AuthenticationManager {
    
    func saveKakaoAccessToken(accessToken: String) throws {
        do {
            try keychainManager.saveToken(accessToken, signInProvider: .kakao, tokenType: .accessToken)
        } catch {
            throw error
        }
    }
    
}
#endif
