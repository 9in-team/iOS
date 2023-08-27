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
    
    private let authManager: AuthenticationManager
    private let networkService: NetworkProtocol
    private var cancellables: Set<AnyCancellable>
    
    init(with networkService: NetworkProtocol) {
        self.authManager = AuthenticationManager.shared
        self.networkService = networkService
        self.cancellables = .init()
    }
    
    deinit {
        self.cancellables = .init()
        print("DEINIT: AppleAuthService")
    }
    
}

extension AppleAuthService {
    
    func signIn(with authorization: ASAuthorization) throws {
        
        print("Apple signin Result \(authorization)")
        print("Apple signin Credential \(authorization.credential)")
        print("Apple signin Privicder \(authorization.provider)")
        
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            checkSignInState(for: credential.user) { result in
                switch result {
                case .success(_):
                    do {
                        try KeychainManager.shared.saveToken(credential.user, 
                                                             signInProvider: .apple,
                                                             tokenType: .accessToken)
                        self.authManager.isSingIn = true
                        self.authManager.lastSignInProvider = .apple
                    } catch {
                        print("AppleLogin UserId 키체인 저장 실패: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("로그인 에러: \(error)")
                }
            }
        } else {
            throw AppleAuthError.credentialError
        }
                
    }
    
    func getSignedSession() throws {
        if AuthenticationManager.shared.lastSignInProvider == .apple {
            do {
                let userId = try KeychainManager.shared.getToken(signInProvider: .apple, tokenType: .accessToken)

                checkSignInState(for: userId) { result in
                    switch result {
                    case .success(_):
                        break
                    case .failure(let error):
                        print("로그인 에러: \(error)")
                        return
                    }
                }
                
            } catch {
                throw error
            }
        }
    }
    
    private func appleCredentialHandler(_ credential: ASAuthorizationAppleIDCredential) throws -> AppleSignInRequest {
        let state = credential.state
        let code = credential.authorizationCode
        let token = credential.identityToken
        let user = credential.user
        
        guard let token = token else { throw AppleAuthError.tokenIsNil }
        
        return AppleSignInRequest(state: state, code: code, idToken: token, user: user)
    }
    
    private func checkSignInState(for userId: String,
                                  completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let provider = ASAuthorizationAppleIDProvider()
        
        provider.getCredentialState(forUserID: userId) { state, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            switch state {
            case .revoked:
                completion(.failure(AppleAuthError.sessionRevoked))
            case .authorized:
                completion(.success(true))
            case .notFound:
                completion(.failure(AppleAuthError.idNotFound))
            case .transferred:
                completion(.failure(AppleAuthError.unknown))
            @unknown default:
                completion(.failure(AppleAuthError.unknown))
            }
        }
    }
    
}
