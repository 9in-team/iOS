//
//  HeaderType.swift
//  9in.team
//
//  Created by ์กฐ์ํ on 2023/01/13.
//

enum HeaderType {
    
    case none
    case test
    
    func get() -> [String: String] {
        switch self {
        case .none:
            return [:]
        case .test:
            return ["Content-Type": "application/json"]
        }
    }
    
}
