//
//  UserAuthManager.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/18.
//

import SwiftUI
import Combine
import KakaoSDKUser

class UserAuthManager: ObservableObject {
    
    private var keychainManager = KeychainManager.shared
    private var networkService = NetworkService()
    private var cancellable = Set<AnyCancellable>()
    
    @Published var userData: UserData?
    
    @AppStorage("isSignIn") var isSingIn = false
    
    static let shared = UserAuthManager()
    
    private init() { }
//    
//    func fetchKakaoLoginToken() -> String {
//        return keychainManager.getToken()
//    }
//    
    func logout() {
        UserApi.shared.logout { _ in
            self.isSingIn = false
            self.userData = nil
            self.keychainManager.deleteToken(signInProvider: .kakao)
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
