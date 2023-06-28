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
    
    @Published var userData: UserData?
    
    @AppStorage("isSignIn") var isSingIn = false
    
    static let shared = UserAuthManager()
    
    private init() { }
    
    func fetchKakaoLoginToken() throws -> String {
        do {
            return try KeychainManager.shared.getToken(signInProvider: .kakao, tokenType: .accessToken)
        } catch {
            throw error
        }
    }
    
    func logout(signInProvider: SignInProviderType = .kakao) {

        UserApi.shared.logout { _ in
            self.isSingIn = false
            self.userData = nil
            self.keychainManager.deleteToken(signInProvider: signInProvider)
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

extension UserAuthManager {
    
    func requestKakaoLogin(completion: @escaping (Error?) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                do {
                    if let error = error {
                        print("DEBUG: \(#function) \(error.localizedDescription)")
                        completion(error)
                    }
                    try self?.requestKakaoSession(oauthToken: oauthToken)
                    completion(nil)
                } catch {
                    // 에러 처리 로직
                    // 카카오톡 로그인 실패
                    if let error = error as? KakaoAuthError {
                        print("DEBUG: \(#function) \(error.localizedDescription)")
                        completion(error)
                    } else if let error = error as? KeychainError {
                        print("DEBUG: \(#function) \(error.localizedDescription)")
                        completion(error)
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                do {
                    if let error = error {
                        completion(error)
                    }
                    try self?.requestKakaoSession(oauthToken: oauthToken)
                } catch {
                    // 카카오 웹 로그인 실패
                    if let keychainError = error as? KeychainError {
                        // 알럿 -> 키체인 에러 (사용자: 토큰 저장 실패)
                        completion(keychainError)
                    } else if let kakaoAuthError = error as? KakaoAuthError {
                        // 알럿 -> 키체인 에러
                        completion(kakaoAuthError)
                    }
                }
            }
        }
    }

    /// 토큰을 통해 로그인 세션 요청
    /// - 에러처리: KakaoAuthError or KeychainError
    private func requestKakaoSession(oauthToken: OAuthToken?) throws {
        if let accessToken = oauthToken?.accessToken {
            do {
                try KeychainManager.shared.saveToken(accessToken, signInProvider: .kakao, tokenType: .accessToken)
                print("✅DEBUG: 토큰 저장 성공! ( kakaoLoginClosure )")
                var loginError: KakaoAuthError?
                kakaoLogin(accessToken: accessToken) { error in
                    if let error = error {
                        loginError = error
                    }
                }
                
                if let loginError = loginError {
                    print("DEBUG: \(#function) \(loginError.localizedDescription)")
                    throw loginError
                }
                
            } catch {
                print("DEBUG: \(#function) \(error.localizedDescription)")
                throw error
            }
        } else {
            throw KakaoAuthError.tokenIsNil
        }
    }
    
    // 카카오 로그인
    private func kakaoLogin(accessToken: String, completion: @escaping (KakaoAuthError?) -> Void) {
        
        print("DEBUG: 카카오 로그인을 요청합니다.")
        
        let parameters = ["accessToken": accessToken]
        
        networkService.POST(headerType: HeaderType.test,
                            urlType: UrlType.testDomain,
                            endPoint: EndPoint.login.get(),
                            parameters: parameters,
                            returnType: UserDataApiResponse.self)
            .sink { [weak self] result in
                switch result {
                case .failure(let error):
                    if self?.isSingIn == true {
                        self?.logout()
                        print(error.localizedDescription)
                        completion(KakaoAuthError.sessionExpired)
                    } else {
                        completion(KakaoAuthError.unknown)
                    }
                case .finished:
                    break
                }
            } receiveValue: { [weak self] responseData in
                if let responseData = responseData.detail {
                    let userData = UserData(id: responseData.id,
                                            email: responseData.email,
                                            nickName: responseData.nickname,
                                            profileImageUrl: responseData.imageUrl,
                                            signInProvider: .kakao)
                    self?.userData = userData
                    self?.isSingIn = true
                    completion(nil)
                } else {
                    self?.logout(signInProvider: .kakao)
                    completion(KakaoAuthError.userdataFetchFailure)
                }
            }
            .store(in: &cancellables)
    }
    
    // 기존 토큰으로 자동로그인
    func getLoginSession(completion: @escaping (Error?) -> Void) {
        do {
            print("DEBUG: 세션을 가져옵니다.")
            self.kakaoLogin(accessToken: try fetchKakaoLoginToken()) { error in
                if let error = error {
                    print("DEBUG: 카카오 로그인 에러발생 \(error.localizedDescription)")
                    completion(error)
                }
                print("DEBUG: 로그인 성공.")
                completion(nil)
            }
        } catch {
            print("DEBUG: \(#function) \(error.localizedDescription)")
            completion(error)
        }
    }

}

enum KakaoAuthError: Error {

    case unknown
    case tokenIsNil
    case sessionExpired
    case userdataFetchFailure
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "알수없는 카카오 인증 에러"
        case .tokenIsNil:
            return "카카오 인증 토큰이 Nil입니다."
        case .sessionExpired:
            return "카카오 인증 세션이 만료되었습니다."
        case .userdataFetchFailure:
            return "토큰은 유효하지만 카카오 유저 데이터를 가져오지 못했습니다.."
        }
    }
}
