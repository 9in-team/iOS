//
//  CredentialManager.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/18.
//

import SwiftUI

class CredentialManager: ObservableObject {
    
    private var loginService: LoginService?
    @Published var userData: UserData?
    @AppStorage("isSignIn") var isSingIn = false
    
    static let shared = CredentialManager()
    
    private init() {

    }
    
    func fetchUserData() -> UserData? {
        return userData
    }
    
    func changeProfileImage(image: UIImage) {
        
    }
    
}

enum LoginService {
    case kakao
}
