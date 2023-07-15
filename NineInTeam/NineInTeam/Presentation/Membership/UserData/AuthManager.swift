//
//  AuthManager.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/18.
//

import SwiftUI
import Combine
import KakaoSDKUser
import KakaoSDKAuth

class AuthManager: ObservableObject {
    
    private var keychainManager = KeychainManager.shared
    private var networkService = NetworkService()
    private var cancellables = Set<AnyCancellable>()
    
    @AppStorage("lastSignProvider") var lastSignInProvider: SignInProviderType = .notSigned
    @AppStorage("isSignIn") var isSingIn = false
    @Published var userData: UserData?
    
    static let shared = AuthManager()
    
    private init() { }

}

extension AuthManager {
    
    func login(provider: SignInProviderType, completion: @escaping (Error?) -> Void) {
        switch provider {
        case .kakao:
            KakaoAuthService(authManager: self).requestLogin { result in
                switch result {
                case .success(_):
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        default:
            completion(LoginError.notSigned)
        }
    }
    
    func getSession(completion: @escaping (Error?) -> Void) {
        
        switch lastSignInProvider {
        case .kakao:
            KakaoAuthService(authManager: self)
                .getLoginSession(completion: completion)
        default:
            completion(LoginError.unknownSession)
        }
        
    }
    
    func logout() {
        
        self.isSingIn = false
        self.userData = nil
        
        self.keychainManager.deleteToken(signInProvider: lastSignInProvider)
        
        switch lastSignInProvider {
        case .kakao:
            KakaoAuthService(authManager: self).kakaoLogout()
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
    
}

// 카카오 로그인 Test Stub
#if canImport(XCTest)
extension AuthManager {
    
    func saveKakaoAccessToken(accessToken: String) throws {
        do {
            try keychainManager.saveToken(accessToken, signInProvider: .kakao, tokenType: .accessToken)
        } catch {
            throw error
        }
    }
    
}
#endif

enum LoginError: Error {
    
    case notSigned
    case notImplemented
    case unknownSession
    
}
