//
//  UserAuthManager.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/18.
//

import SwiftUI
import Combine

class UserAuthManager: ObservableObject {
    
    // TODO: 세션 유지하기
    // TODO: 로그아웃 -> 유저데이터 nil, isSignIn false
    private var loginService: LoginService?
    private var keychainManager = KeychainManager.shared
    @Published var userData: UserData?
    @AppStorage("isSignIn") var isSingIn = false
    
    static let shared = UserAuthManager()
    
    private init() {
        if isSingIn {
            // TODO: 토큰 통해서 로그인 처리
            // [v] Keychain 도입 전 테스트로 UserDefault로 토큰 저장하기 (실 운영시 파기)
            // [v] 로그아웃 버튼이 없으므로 테스트 작업용 로그아웃 버튼 추가.
            // [] Keychain Service에 저장된 토큰 가져오기
            // [] 서버에 보내서 로그인세션 가져오기.
            // [] 토큰 만료시 서버에 Refresh Token요청하기
            // [] 위에 하나라도 실패하면 isSignIn = false 하기.
        }
    }
    
    func fetchKakaoLoginToken() -> String {
        return keychainManager.getToken()
    }

    func logout() {
        self.isSingIn = false
        self.userData = nil
    }

}

enum LoginService {
    case kakao
}
