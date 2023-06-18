//
//  UserAuthManager.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/18.
//

// TODO: 토큰 통해서 로그인 처리
// [v] Keychain 도입 전 테스트로 UserDefault로 토큰 저장하기 (실 운영시 파기)
// [v] 로그아웃 버튼이 없으므로 테스트 작업용 로그아웃 버튼 추가.
// [v] 서버에 토큰 보내서 로그인 세션 가져오기.
// [] Keychain Service에 저장된 토큰 가져오기 구현
// [] 토큰 만료시 서버에 Refresh Token요청하기
// [] 위에 하나라도 실패하면 isSignIn = false 하기.

import SwiftUI
import Combine
import KakaoSDKUser

class UserAuthManager: ObservableObject {
    
    private var keychainManager = KeychainManager.shared
    
    @Published var userData: UserData?
    
    @AppStorage("isSignIn") var isSingIn = false
    
    static let shared = UserAuthManager()
    
    private init() { }
    
    func fetchKakaoLoginToken() -> String {
        return keychainManager.getToken()
    }

    func logout() {
        UserApi.shared.logout { _ in
            self.isSingIn = false
            self.userData = nil
            self.keychainManager.deleteToken()
            print("DEBUG LOGOUT")
        }
    }

}
