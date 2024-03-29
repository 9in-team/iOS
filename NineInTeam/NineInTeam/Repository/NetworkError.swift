//
//  NetworkType.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/13.
//

import Foundation

enum NetworkError: Error {
    
    case invalidURL
    case responseError
    case statusCode(Int)
    case parameterConvertError
    case invalidBody
    case invalidEndpoint
    case badRequest
    case invalidMediaUrl
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "\(self): 올바르지 않은 URL"
        case .responseError:
            return "\(self): 응답 오류"
        case .statusCode(let code):
            return "\(self): \(code) 오류"
        case .parameterConvertError:
            return "\(self): 파라미터 변환 오류"
        case .invalidBody:
            return "\(self): 잘못된 Body 형식"
        case .invalidEndpoint:
            return "\(self): Endpoint가 올바르지 않습니다."
        case .badRequest:
            return "\(self): 잘못된 HTTPRequest"
        case .invalidMediaUrl:
            return "\(self): 잘못된 컨텐츠 URL"
        case .unknown:
            return "\(self): 알수 없는 오류"
        }
    }
    
}
