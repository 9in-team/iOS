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
}

class NetworkService: NetworkProtocol {
    private var cancellables = Set<AnyCancellable>()
    
    func GET<T>(endPoint: String,
                parameters: [String: String]? = [:],
                type: T.Type) -> Future<T, Error> where T: Decodable {
        return Future<T, Error> { [weak self] promise in
            var urlString = "https://\(endPoint)"
            
            if !parameters!.isEmpty {
                urlString += "?"
                for parameter in parameters! {
                    urlString += "\(parameter.key)=\(parameter.value)&"
                    
                    if urlString.last == "&" {
                        urlString.removeLast()
                    }
                }
            }
            
            guard let self = self, let url = URL(string: urlString) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let session = URLSession.shared
            session.dataTaskPublisher(for: request).tryMap { (data, response) -> Data in
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
    
    func POST<T>(endPoint: String,
                 parameters: [String: String]? = [:],
                 requestBody: [String: Any]? = [:],
                 type: T.Type) -> Future<T, Error> where T: Decodable {
        return Future<T, Error> { [weak self] promise in
            var urlString = "https://\(endPoint)"
            
            if !parameters!.isEmpty {
                urlString += "?"
                for parameter in parameters! {
                    urlString += "\(parameter.key)=\(parameter.value)&"
                    
                    if urlString.last == "&" {
                        urlString.removeLast()
                    }
                }
            }
            
            guard let self = self, let url = URL(string: urlString) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            var request = URLRequest(url: url)
            request.timeoutInterval = 600
            request.httpMethod = "POST"
            
            // application/x-www-form-urlencoded 방식
            if let requestBody = requestBody {
                let param = requestBody.map {
                    "\($0.key)=\($0.value)"
                }.joined(separator: "&")
                request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.setValue(String(param.count), forHTTPHeaderField: "Content-Length")
                request.httpBody = param.data(using: .utf8)
            }
            
            let session = URLSession.shared
            session.dataTaskPublisher(for: request).tryMap { (data, response) -> Data in
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
}
