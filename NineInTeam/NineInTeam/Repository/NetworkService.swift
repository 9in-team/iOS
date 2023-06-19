//
//  NetworkService.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/01.
//

import Foundation
import Combine

class NetworkService: NetworkProtocol {

    private var session = URLSession.shared
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - GET
    func GET<T>(headerType: HeaderType,
                urlType: UrlType,
                endPoint: String,
                parameters: [String: String] = [:],
                returnType: T.Type) -> Future<T, Error> where T: Decodable {
        return Future<T, Error> { [weak self] promise in
            guard let self = self else {
                return promise(.failure(LifeCycleError.memoryLeak))
            }
            
            let urlString = "\(urlType.get())\(endPoint)\(self.queryString(from: parameters))"
            guard let url = URL(string: urlString) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            self.session.dataTaskPublisher(for: request).tryMap { (data, response) -> Data in
                print("data :: \(String(decoding: data, as: UTF8.self))")
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw NetworkError.responseError
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    switch error {
                    case let decodingError as DecodingError:
                        promise(.failure(decodingError))
                    case let apiError as NetworkError:
                        promise(.failure(apiError))
                    default:
                        promise(.failure(NetworkError.unknown))
                    }
                }
            }, receiveValue: {
                promise(.success($0))
            })
            .store(in: &self.cancellables)
        }
    }
    
    // MARK: - POST
    func POST<T>(headerType: HeaderType,
                 urlType: UrlType,
                 endPoint: String,
                 parameters: [String: Any] = [:],
                 returnType: T.Type) -> Future<T, Error> where T: Decodable {
        return Future<T, Error> { [weak self] promise in
        
            guard let self = self else {
                return promise(.failure(LifeCycleError.memoryLeak))
            }
                        
            guard let url = URL(string: "\(urlType.get())\(endPoint)") else {
                return promise(.failure(NetworkError.invalidURL))
            }
                                                
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
    
            _ = headerType.get().map { (key, value) in
                request.addValue(value, forHTTPHeaderField: key)
            }
                                    
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters) {
                request.httpBody = jsonData
            }
                        
            self.session.dataTaskPublisher(for: request).tryMap { (data, response) -> Data in
                print("data :: \(String(decoding: data, as: UTF8.self))")
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.unknown
                }
                
                let statusCode = httpResponse.statusCode
                
                switch statusCode {
                case 200...399:
                    return data
                case 400...599:
                    throw NetworkError.statusCode(statusCode)
                default:
                    throw NetworkError.unknown
                }
                
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    print("DEBUG POST ERROR: \(error)")
                    switch error {
                    case let decodingError as DecodingError:
                        promise(.failure(decodingError))
                    case let apiError as NetworkError:
                        promise(.failure(apiError))
                    case let urlError as URLError:
                        promise(.failure(urlError))
                    default:
                        promise(.failure(NetworkError.unknown))
                    }
                }
            }, receiveValue: {
                promise(.success($0))
            })
            .store(in: &self.cancellables)
        }
    }
    
    func PUT<T>(headerType: HeaderType,
                urlType: UrlType,
                endPoint: String,
                parameters: [String: Any] = [:],
                returnType: T.Type) -> Future<T, Error> where T: Decodable {
        return Future<T, Error> { [weak self] promise in
            
            guard let self = self else {
                return promise(.failure(LifeCycleError.memoryLeak))
            }
            
            guard let url = URL(string: "\(urlType.get())\(endPoint)") else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
    
            _ = headerType.get().map { (key, value) in
                request.addValue(value, forHTTPHeaderField: key)
            }
                                    
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters) {
                request.httpBody = jsonData
            }
            
            self.session.dataTaskPublisher(for: request).tryMap { (data, response) -> Data in
                print("data :: \(String(decoding: data, as: UTF8.self))")
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.unknown
                }
                
                let statusCode = httpResponse.statusCode
                
                switch statusCode {
                case 200...399:
                    return data
                case 400...599:
                    throw NetworkError.statusCode(statusCode)
                default:
                    throw NetworkError.unknown
                }
                
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    print("DEBUG POST ERROR: \(error)")
                    switch error {
                    case let decodingError as DecodingError:
                        promise(.failure(decodingError))
                    case let apiError as NetworkError:
                        promise(.failure(apiError))
                    case let urlError as URLError:
                        promise(.failure(urlError))
                    default:
                        promise(.failure(NetworkError.unknown))
                    }
                }
            }, receiveValue: {
                promise(.success($0))
            })
            .store(in: &self.cancellables)
        }
    }
//    
//    func putRequest(bodyData: UserUpdateApiModel, endpoint: String) throws -> URLRequest {
        
//        let baseUrl = "https://9inteam.heon.dev/\(endpoint)"
//
//        guard let serverUrl = URL(string: baseUrl) else {
//            throw NetworkError.invalidEndpoint
//        }
//
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "cache-control": "no-cache"
//        ]
        
//        let reqData = bodyData
//
//        guard let encodedReqData = try? JSONEncoder().encode(reqData) else {
//            throw NetworkError.invalidBody
//        }
////
//        var request = URLRequest(url: serverUrl)
//        request.httpMethod = "PUT"
//        request.headers = headers
//        request.httpBody = encodedReqData
//
//        return request
//
//    }
//
//    func putUserData(bodyData: UserUpdateApiModel,
//                     endpoint: String,
//                     session: URLSession = URLSession.shared) throws -> URLSession.DataTaskPublisher {
//        let request = try putRequest(bodyData: bodyData, endpoint: endpoint)
//        return session.dataTaskPublisher(for: request)
//    }
//
//    func validateRequest(_ data: Data, _ response: URLResponse) throws -> Data {
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw NetworkError.badRequest
//        }
//        guard (200..<300).contains(httpResponse.statusCode) else {
//            throw NetworkError.statusCode(httpResponse.statusCode)
//        }
//        return data
//    }
//
//    func putPublisher(bodyData: UserUpdateApiModel,
//                      endpoint: String) -> AnyPublisher<UserUpdateResponse, Error>? {
//        return try? putUserData(bodyData: bodyData, endpoint: endpoint)
//            .tryMap { try self.validateRequest($0.data, $0.response) }
//            .decode(type: UserUpdateResponse.self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//    }
//
//    func updateData(nickname: String, imageUrl: URL, completion: @escaping (Result<Void, Error>) -> Void) {
//        if let currentData = userData {
//
//            let model = UserUpdateApiModel(nickname: nickname, imageUrl: imageUrl.absoluteString)
//
//            putPublisher(bodyData: model, endpoint: "account/\(currentData.id)")?
//                .map(\.detail)
//                .receive(on: RunLoop.main)
//                .sink(receiveCompletion: { result in
//                    switch result {
//                    case .failure(let error):
//                        error.printAndTypeCatch(location: "updateData")
//                        completion(.failure(error))
//                    case .finished:
//                        print("완료")
//                        completion(.success(()))
//                    }
//                }, receiveValue: {[weak self] updatedData in
//                    self?.userData = UserData(id: currentData.id,
//                                             email: currentData.email,
//                                             nickName: updatedData.nickname,
//                                             profileImageUrl: updatedData.imageUrl,
//                                             loginService: currentData.loginService)
//                    print("DEBUG UPDATEDDATA: \(updatedData)")
//                })
//                .store(in: &cancellable)
//        }
//    }


    // MARK: - Make QueryString
    func queryString(from parameters: [String: String]) -> String {
        var queryString = ""
        
        if !parameters.isEmpty {
            queryString += "?"
            for parameter in parameters {
                queryString += "\(parameter.key)=\(parameter.value)&"
                
                if queryString.last == "&" {
                    queryString.removeLast()
                }
            }
        }
        
        return queryString
    }
    
}
