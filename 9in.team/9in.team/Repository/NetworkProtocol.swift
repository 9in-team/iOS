//
//  NetworkProtocol.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/01.
//

import Combine

protocol NetworkProtocol {
    
    func GET<T: Decodable>(endPoint: String,
                           parameters: [String: String]?,
                           type: T.Type) -> Future<T, Error>
    
    func POST<T: Decodable>(endPoint: String,
                            parameters: [String: String]?,
                            requestBody: [String: Any]?,
                            type: T.Type) -> Future<T, Error>
    
}
