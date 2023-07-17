//
//  AppleAuthService.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/07/05.
//

import SwiftUI
import Combine
import AuthenticationServices

final class AppleAuthService {
    
    private let authManager: AuthManager
    private let networkService: NetworkProtocol
    private var cancellables: Set<AnyCancellable>
    
    init(with networkService: NetworkProtocol, cancellables: Set<AnyCancellable> = []) {
        self.authManager = AuthManager.shared
        self.networkService = networkService
        self.cancellables = cancellables
    }
    
    deinit {
        print("DEINIT: AppleAuthService")
    }
    
}

extension AppleAuthService {
    
    func signIn(with authorization: ASAuthorization) throws {
        
        print("Apple signin Result \(authorization)")
        print("Apple signin Credential \(authorization.credential)")
        print("Apple signin Privicder \(authorization.provider)")
        
        switch authorization.credential {
        case let asCredential as ASAuthorizationAppleIDCredential:
            
            var json: [String: Any]?
            
            do {
                let body = try appleCredentialHandler(asCredential)
                let encodedJSONData = try JSONEncoder().encode(body)
                json = try JSONSerialization.jsonObject(with: encodedJSONData) as? [String: Any]
            } catch {
                throw error
            }
            
            guard let parameters = json else { throw AppleAuthError.jsonIsNil }
            
            networkService.POST(headerType: .test,
                                urlType: .testDomain,
                                endPoint: "loginWithApple",
                                parameters: parameters,
                                returnType: SignInDaoResponse.self)
            .tryCompactMap { response in
                guard let detail = response.detail else {
                    throw AppleAuthError.tokenIsNil
                }
                return detail
            }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { receivedData in
                print(receivedData)
                return
            }
            .store(in: &cancellables)
            
        default:
            break
        }
        
    }
    
    private func appleCredentialHandler(_ credential: ASAuthorizationAppleIDCredential) throws -> AppleSignInRequest {
        let state = credential.state
        let code = credential.authorizationCode?.base64EncodedString()
        let token = credential.identityToken?.base64EncodedString()
        let user = credential.user
        
        print("state : \(state ?? "state is nil")")
        print("code : \(code ?? "code is nil")")
        print("token : \(token ?? "token is nil")")
        print("user : \(user)")
        
        guard let token = token else { throw AppleAuthError.tokenIsNil }
        
        return AppleSignInRequest(state: state,
                                  code: code,
                                  idToken: token,
                                  user: user)
    }
    
    func signOut() {
        
    }
    
}
