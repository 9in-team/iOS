//
//  UrlType.swift
//  9in.team
//
//  Created by ์กฐ์ํ on 2023/02/10.
//

enum UrlType {
    
    case test
    
    func get() -> String {
        switch self {
        case .test:
            return "http://223.130.134.106:8080/"
        }
    }
    
}
