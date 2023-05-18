//
//  UrlType.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/10.
//

enum UrlType {
    
    case test
    case testLocal

    func get() -> String {
        switch self {
        case .test:
            return "http://223.130.134.106:8080/"
        case .testLocal:
            return "http://127.0.0.1:8080/"
        }
    }
    
}
