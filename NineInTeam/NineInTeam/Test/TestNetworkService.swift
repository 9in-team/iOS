//
//  TestNetworkService.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/20.
//

import Foundation
import Combine

class TestNetworkService: NetworkProtocol {
    
    func GET<T>(headerType: HeaderType,
                urlType: UrlType,
                endPoint: String,
                parameters: [String: String] = [:],
                returnType: T.Type) -> Future<T, Error> where T: Decodable {
        return result(parameters, T.self)
    }
    
    func POST<T>(headerType: HeaderType,
                 urlType: UrlType,
                 endPoint: String,
                 parameters: [String: Any] = [:],
                 returnType: T.Type) -> Future<T, Error> where T: Decodable {
        return result(parameters, T.self)
    }
    
    func PUT<T>(headerType: HeaderType,
                urlType: UrlType,
                endPoint: String,
                parameters: [String: Any],
                returnType: T.Type) -> Future<T, Error> where T: Decodable {
        return result(parameters, T.self)
    }
    
    func DELETE<T>(headerType: HeaderType,
                   urlType: UrlType,
                   endPoint: String,
                   parameters: [String: Any],
                   returnType: T.Type) -> Future<T, Error> where T: Decodable {
        return result(parameters, T.self)
    }
    
    func result<T>(_ parameters: [String: Any], _ returnType: T.Type) -> Future<T, Error> where T: Decodable {
        return Future<T, Error> { promise in
            guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
                promise(.failure(NetworkError.unknown))
                return
            }
            
            guard let json = try? JSONDecoder().decode(T.self, from: jsonData) else {
                promise(.failure(NetworkError.unknown))
                return
            }
                        
            promise(.success(json))
        }
    }
    
}
