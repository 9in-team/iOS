//
//  NetworkService.swift
//  9in.team
//
//  Created by ์กฐ์ํ on 2023/01/01.
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
