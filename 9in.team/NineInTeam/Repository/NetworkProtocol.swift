//
//  NetworkProtocol.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/01.
//

import Combine

protocol NetworkProtocol {
    
    func GET<T: Decodable>(headerType: HeaderType,
                           urlType: UrlType,
                           endPoint: String,
                           parameters: [String: String],
                           returnType: T.Type) -> Future<T, Error>
    
    func POST<T: Decodable>(headerType: HeaderType,
                            urlType: UrlType,
                            endPoint: String,
                            parameters: [String: Any],
                            returnType: T.Type) -> Future<T, Error>
    
}
