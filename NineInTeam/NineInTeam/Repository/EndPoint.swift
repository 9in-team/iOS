//
//  EndPoint.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/05.
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
            return "account"
        case .logout:
            return "logout"
        }
    }
    
}
