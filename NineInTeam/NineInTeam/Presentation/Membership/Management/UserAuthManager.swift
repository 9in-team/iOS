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
import Alamofire
import KakaoSDKUser

class UserAuthManager: ObservableObject {
    
    private var keychainManager = KeychainManager.shared
    private var networkService = NetworkService()
    private var cancellable = Set<AnyCancellable>()
    
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
    
    func putRequest<T: Encodable>(bodyData: T, endpoint: String) throws -> URLRequest {
        
        let baseUrl = "https://9inteam.heon.dev/\(endpoint)"
        
        guard let serverUrl = URL(string: baseUrl) else {
            throw NetworkError.invalidEndpoint
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "cache-control": "no-cache"
        ]
        
        let reqData = bodyData
        
        guard let encodedReqData = try? JSONEncoder().encode(reqData) else {
            throw NetworkError.invalidBody
        }
        
        var request = URLRequest(url: serverUrl)
        request.httpMethod = "PUT"
        request.headers = headers
        request.httpBody = encodedReqData
        
        return request
        
    }
    
    func putUserData(bodyData: UserUpdateApiModel,
                     endpoint: String,
                     session: URLSession = URLSession.shared) throws -> URLSession.DataTaskPublisher {
        let request = try putRequest(bodyData: bodyData, endpoint: endpoint)
        return session.dataTaskPublisher(for: request)
    }
    
    func validateRequest(_ data: Data, _ response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badRequest
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.statusCode(httpResponse.statusCode)
        }
        return data
    }
    
    func putPublisher(bodyData: UserUpdateApiModel,
                      endpoint: String) -> AnyPublisher<UserApiModel, Error>? {
        return try? putUserData(bodyData: bodyData, endpoint: endpoint)
            .tryMap { try self.validateRequest($0.data, $0.response) }
            .decode(type: UserApiModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func updateData(nickname: String, imageUrl: URL) {
        if let currentData = userData {
            
            let model = UserUpdateApiModel(nickname: nickname, imageUrl: imageUrl.absoluteString)
            
            putPublisher(bodyData: model, endpoint: "account/\(currentData.id)")?
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        self.errorPrinter(error)
                        return
                    case .finished:
                        print("완료")
                    }
                }, receiveValue: {[unowned self] updatedData in
                    self.userData = UserData(id: currentData.id,
                                             email: currentData.email,
                                             nickName: updatedData.nickname,
                                             profileImageUrl: updatedData.imageUrl,
                                             loginService: currentData.loginService)
                    print("DEBUG UPDATEDDATA: \(updatedData)")
                    return
                })
                .store(in: &cancellable)
            
            //
            //            .tryMap(\.detail)
            //            .sink { completion in
            //                switch completion {
            //                case .failure(let error):
            //                    print("DEBUG UPDATE DATA ERROR: \(error.localizedDescription)")
            //                case .finished:
            //                    break
            //                }
            //            } receiveValue: { receivedData in
            //                guard let currentData = self.userData else { return }
            //                if let updatedApiData = receivedData {
            //
            //                    let updatedUserData = UserData(id: currentData.id,
            //                                        email: currentData.email,
            //                                        nickName: updatedApiData.nickname,
            //                                        profileImageUrl: updatedApiData.imageUrl,
            //                                        loginService: currentData.loginService)
            //
            //                    self.userData = updatedUserData
            //                }
            //                return
            //            }
            //            .store(in: &cancellable)
        }
    }
    
    private func errorPrinter(_ error: Error) {
        if let error = error as? NetworkError {
            print("❗️(DEBUG) NetworkError:  \(error.localizedDescription)")
        } else if let error = error as? DecodingError {
            print("❗️(DEBUG) DecodingError:  \(error.localizedDescription)")
        } else if let error = error as? URLError {
            print("❗️(DEBUG) URLError:  \(error.localizedDescription)")
        } else {
            print("❗️(DEBUG) 알수없는 에러:  \(error.localizedDescription)")
        }
    }
    
}

struct UserUpdateApiModel: Encodable {
    let nickname: String
    let imageUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case nickname
        case imageUrl = "imageId"
    }
}
