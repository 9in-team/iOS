//
//  EndPoint.swift
//  9in.team
//
//  Created by ์กฐ์ํ on 2023/02/05.
//

enum EndPoint {
    
    case none
    case join
    case login
    case logout
    
    func get() -> String {
        switch self {
        case .none:
            return ""
        case .join:
            return "join"
        case .login:
            return "login"
        case .logout:
            return "logout"
        }
    }
    
}
