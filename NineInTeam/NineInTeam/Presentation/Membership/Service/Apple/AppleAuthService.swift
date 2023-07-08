//
//  AppleAuthService.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/07/05.
//

import SwiftUI
import AuthenticationServices

enum AppleAuthError: Error {
    
    case tokenIsNil
    
}

class AppleAuthService {

    var authManager: AuthManager

    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    deinit {
        
    }
    
}


// MARK: - Public Methods
extension AppleAuthService {
    
    func signIn(with authorization: ASAuthorization) throws {
        
        switch authorization.credential {
        case let asCredential as ASAuthorizationAppleIDCredential:
            let state = asCredential.state
            let code = asCredential.authorizationCode?.base64EncodedString()
            let token = asCredential.identityToken?.base64EncodedString()
            let user = asCredential.user

            print("state : \(state)")
            print("code : \(code)")
            print("token : \(token)")
            print("user : \(user)")
            
            if let token = token {
                let body = AppleSignInRequest(state: state,
                                              code: code,
                                              idToken: token,
                                              user: user)
//                NetworkService().POST(headerType: .test, urlType: .testLocal, endPoint: "loginWithApple", returnType: )
                
            } else {
                throw AppleAuthError.tokenIsNil
            }
            
        default:
            break
        }
        
        print("Apple signin Result \(authorization)")
        print("Apple signin Credential \(authorization.credential)")
        print("Apple signin Privicder \(authorization.provider)")
        
    }
    
    func signOut() {
        
    }
    
}

struct AppleSignInRequest: Codable {
    let state: String?
    let code: String?
    let idToken: String
    let user: String?
    
    private enum CodingKeys: String, CodingKey {
        case state, code, user
        case idToken = "id_token"
    }
    
}
