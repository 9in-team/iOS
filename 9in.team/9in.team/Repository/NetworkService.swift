//
//  NetworkService.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/01.
//

import Foundation
import Combine

enum NetworkError: Error {
    
    case invalidURL
    case responseError
    case unknown
    case closed
    
}

enum LifeCycleError: Error {
    
    case memoryLeak
    
}

class NetworkService: NetworkProtocol {
    
    private var session = URLSession.shared
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - GET
    func GET<T>(endPoint: String,
                parameters: [String: String] = [:],
                returnType: T.Type) -> Future<T, Error> where T: Decodable {
        return Future<T, Error> { [weak self] promise in
            guard let self = self else {
                return promise(.failure(LifeCycleError.memoryLeak))
            }
            
            let urlString = "https://\(endPoint)\(self.queryString(from: parameters))"
            guard let url = URL(string: urlString) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            self.session.dataTaskPublisher(for: request).tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw NetworkError.responseError
                }
                
                print("data :: \(String(decoding: data, as: UTF8.self))")
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
    func POST<T>(endPoint: String,
                 parameters: [String: Any] = [:],
                 returnType: T.Type) -> Future<T, Error> where T: Decodable {
        return Future<T, Error> { [weak self] promise in
            guard let self = self else {
                return promise(.failure(LifeCycleError.memoryLeak))
            }
            
            let urlString = "https://\(endPoint)"
            guard let url = URL(string: urlString) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            var request = URLRequest(url: url)
            request.timeoutInterval = 600
            request.httpMethod = "POST"
            
            // application/x-www-form-urlencoded 방식
            let param = parameters.map {
                "\($0.key)=\($0.value)"
            }.joined(separator: "&")
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue(String(param.count), forHTTPHeaderField: "Content-Length")
            request.httpBody = param.data(using: .utf8)
               
            self.session.dataTaskPublisher(for: request).tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw NetworkError.responseError
                }

                print("data :: \(String(decoding: data, as: UTF8.self))")
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
    
//
//
//
//
//
//
//
//
    // MARK: - 서버 요청에 필요한 데이터 만드는 메서드
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
