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
    
    func putRequest(bodyData: UserUpdateApiModel, endpoint: String) throws -> URLRequest {
        
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
                      endpoint: String) -> AnyPublisher<UserUpdateResponse, Error>? {
        return try? putUserData(bodyData: bodyData, endpoint: endpoint)
            .tryMap { try self.validateRequest($0.data, $0.response) }
            .decode(type: UserUpdateResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func updateData(nickname: String, imageUrl: URL, completion: @escaping (Result<Void, Error>) -> Void) {
        if let currentData = userData {
            
            let model = UserUpdateApiModel(nickname: nickname, imageUrl: imageUrl.absoluteString)
            
            putPublisher(bodyData: model, endpoint: "account/\(currentData.id)")?
                .map(\.detail)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        error.printAndTypeCatch(location: "updateData")
                        completion(.failure(error))
                    case .finished:
                        print("완료")
                        completion(.success(()))
                    }
                }, receiveValue: {[weak self] updatedData in
                    self?.userData = UserData(id: currentData.id,
                                             email: currentData.email,
                                             nickName: updatedData.nickname,
                                             profileImageUrl: updatedData.imageUrl,
                                             loginService: currentData.loginService)
                    print("DEBUG UPDATEDDATA: \(updatedData)")
                })
                .store(in: &cancellable)
        }
    }
}

struct UserUpdateResponse: Codable {
    let detail: UserUpdateApiModel
}

struct UserUpdateApiModel: Codable {
    let nickname: String
    let imageUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case nickname
        case imageUrl = "imageId"
    }
}
