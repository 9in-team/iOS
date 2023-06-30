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
    
    @AppStorage("lastSignProvider") var lastSignInProvider: SignInProviderType = .notSigned
    @AppStorage("isSignIn") var isSingIn = false
    @Published var userData: UserData?
    
    static let shared = UserAuthManager()
    
    private init() { }
    
}

extension UserAuthManager {
    
    func login(provider: SignInProviderType, completion: @escaping (Error?) -> Void) {
        switch provider {
        case .kakao:
            KakaoSignService(authManager: self)
                .requestKakaoLogin(completion: completion)
        default:
            completion(LoginError.notSigned)
        }
    }
    
    func getSession(completion: @escaping (Error?) -> Void) {
        
        switch lastSignInProvider {
        case .kakao:
            KakaoSignService(authManager: self)
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
            KakaoSignService(authManager: self).kakaoLogout()
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

// 카카오 로그인 바인더
extension UserAuthManager {
    

    
}

enum LoginError: Error {
    
    case notSigned
    case notImplemented
    case unknownSession
    
}
