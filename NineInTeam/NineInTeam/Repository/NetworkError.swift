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
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
    case parameterConvertError
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "\(self): 올바르지 않은 URL"
        case .responseError:
            return "\(self): 응답 오류"
        case .clientError:
            return "\(self): 클라이언트 오류"
        case .serverError:
            return "\(self): 서버 오류"
        case .parameterConvertError:
            return "\(self): 파라미터 변환 오류"
        case .unknown:
            return "\(self): 알수 없는 오류"
        }
    }
    
}
