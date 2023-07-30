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
        
        let credential = authorization.credential as! ASAuthorizationAppleIDCredential
        
        var json: [String: Any]?
        
        do {
            let body = try appleCredentialHandler(credential)
            print("Body DEBUG: \(body)")
            let encodedJSONData = try JSONEncoder().encode(body)
            
            json = try JSONSerialization.jsonObject(with: encodedJSONData) as? [String: Any]
        } catch {
            throw error
        }
        
        guard let body = json else { throw AppleAuthError.jsonIsNil }
        print("로그인 진행중...")
        
        networkService.POST(headerType: .test,
                            urlType: .test,
                            endPoint: EndPoint.loginWithApple.get(),
                            parameters: body,
                            returnType: SignInResponseData.self)
        .tryCompactMap { response in
            guard let detail = response.detail else {
                throw AppleAuthError.tokenIsNil
            }
            return detail
        }
        .sink { completion in
            switch completion {
            case .finished:
                print("로그인 완료")
            case .failure(let error):
                print(error)
            }
        } receiveValue: { receivedData in
            print("Login DEBUG: \(receivedData)")
            return
        }
        .store(in: &cancellables)
        
    }
    
    private func appleCredentialHandler(_ credential: ASAuthorizationAppleIDCredential) throws -> AppleSignInRequest {
        let state = credential.state
        let code = credential.authorizationCode
        let token = credential.identityToken
        let user = credential.user

        print("DEBUG Credential: \(credential)")
        // print("state : \(state ?? "state is nil")")
        // print("code : \(code ?? "code is nil")")
        // print("token : \(token ?? "token is nil")")
        print("user : \(user)")
        //
        guard let token = token else { throw AppleAuthError.tokenIsNil }
        
        return AppleSignInRequest(state: state,
                                  code: code,
                                  idToken: token,
                                  user: user)
    }
    
}
