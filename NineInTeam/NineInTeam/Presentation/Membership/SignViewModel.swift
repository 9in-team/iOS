//
//  SignViewModel.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/31.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import FirebaseStorage

class SignViewModel: BaseViewModel {
    
    private var service: NetworkProtocol
    private var credentialManager = CredentialManager.shared
    
    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
        super.init()
    }
    
    func autoLogin() {
        // UserDefaults 에서 애플, 카카오 로그인 데이터 가져오기
        credentialManager.isSingIn = true
    }
    
    func canOpen(_ url: URL) {
        if AuthApi.isKakaoTalkLoginUrl(url) {
            if AuthController.handleOpenUrl(url: url) {
                // Toast message : "open"
            }
        } else {
            // Toast message : "don't open"
        }
    }
    
    func requestKakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                self?.kakaoLoginClosure(oauthToken: oauthToken, error: error)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                self?.kakaoLoginClosure(oauthToken: oauthToken, error: error)
            }
        }
    }
    
    // 카카오 로그인 클로저
    private func kakaoLoginClosure(oauthToken: OAuthToken?, error: Error?) {
        if let error = error {
            showAlert(title: error.localizedDescription)
        } else {
            if let accessToken = oauthToken?.accessToken {
                kakaoLogin(accessToken: accessToken)
            } else {
                showAlert(title: "토큰을 가져오지 못했습니다.")
            }
        }
    }
    
    // 로그인
    func kakaoLogin(accessToken: String) {
        let parameters = ["accessToken": accessToken]
        
        willStartLoading()
        service.POST(headerType: HeaderType.test,
                     urlType: UrlType.testDomain,
                     endPoint: EndPoint.login.get(),
                     parameters: parameters,
                     returnType: KakaoLoginResponse.self)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("DEBUG RESPONSE FAIL: \(error.localizedDescription)")
                    self?.showToast(title: "")
                case .finished:
                    print("DEBUG RESPONSE FINISHED!")
                    break
                }
                self?.didFinishLoading()
                
            } receiveValue: { [weak self] responseData in
                print("DEBUG RESPONSE DATA: \(responseData)")

                if let responseData = responseData.detail {
                    print("DEBUG USERDATA: \(responseData)")
                    let userData = UserData(email: responseData.email,
                                            nickName: responseData.nickname,
                                            profileImageUrl: responseData.imageUrl)
                    self?.credentialManager.userData = userData
                    self?.credentialManager.isSingIn = true
                } else {
                    print("DEBUG USERDATA: X")
                }

            }
            .store(in: &cancellables)
    }
    
    // 회원가입
    func join(email: String, nickname: String, imageUrl: String = "") {
        var parameters = ["email": email,
                          "nickname": nickname]
        if !imageUrl.isEmpty {
            parameters["imageId"] = imageUrl
        }        
        
        willStartLoading()
        service.POST(headerType: HeaderType.test,
                     urlType: UrlType.test,
                     endPoint: EndPoint.join.get(),
                     parameters: parameters,
                     returnType: KakaoLoginResponse.self)
            .sink { [weak self] completion in
                guard let self = self else {
                    return
                }
                
                switch completion {
                case .failure(let error):
                    self.showToast(title: "에러가 발생했어요.\n\(error)")
                case .finished:
                    break
                }
                self.didFinishLoading()
            } receiveValue: { [weak self] _ in
                guard self != nil else {
                    return
                }
            }
            .store(in: &cancellables)
    }
    
    func requestUserDataForJoin() {
        UserApi.shared.me { [weak self] (user, error) in
            if let error = error {
                self?.showAlert(title: error.localizedDescription)
            } else {
                guard let email = user?.kakaoAccount?.email else {
                    self?.showAlert(title: "카카오톡 회원정보를 가져오지 못했습니다.")
                    return
                }
                
                guard let nickname = user?.kakaoAccount?.profile?.nickname else {
                    self?.showAlert(title: "카카오톡 회원정보를 가져오지 못했습니다.")
                    return
                }
                
                if let imageUrl = user?.kakaoAccount?.profile?.profileImageUrl {
                    self?.join(email: email, nickname: nickname, imageUrl: imageUrl.absoluteString)
                } else {
                    self?.join(email: email, nickname: nickname)
                }
            }
        }
    }
    
    // Firebase Image Upload
    func uploadImage(_ image: UIImage, completion: @escaping (URL) -> Void) {
        willStartLoading()
                                                        
        guard let data = image.jpegData(compressionQuality: 0.9) else {
            showToast(title: "이미지 변환에 실패했습니다.")
            return
        }
       
        let folder = "ProfileImage"
        let imageName = UUID().uuidString + String(Date().timeIntervalSince1970)
        let path = "\(folder)/\(imageName)"
        
        FirebaseStorageManager.uploadImage(imageData: data, path: path) { [weak self] url, error in
            if error != nil {
                self?.showToast(title: "이미지 업로드를 실패했습니다.")
            } else {
                completion(url!)                
            }
            
            self?.didFinishLoading()
        }               
    }
    
}
