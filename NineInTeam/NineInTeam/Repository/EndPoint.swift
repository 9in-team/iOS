//
//  EndPoint.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/05.
//

enum EndPoint {
    
    case none
    case join
    case loginWithKakao
    case loginWithApple
    case logout
    
    func get() -> String {
        switch self {
        case .none:
            return ""
        case .join:
            return "join"
        case .loginWithKakao:
            return "login-with-kakao"
        case .loginWithApple:
            return "login-with-apple"
        case .logout:
            return "logout"
        }
    }
    
}
