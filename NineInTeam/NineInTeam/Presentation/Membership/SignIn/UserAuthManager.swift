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
    @Published var userData: UserData?
    @Published var isSingIn = false
    
    static let shared = UserAuthManager()
    
    private init() {
    }
    
    func logout() {
        requestLogout()
    }
    
    private func requestLogout() {
        
    }

}

enum LoginService {
    case kakao
}
