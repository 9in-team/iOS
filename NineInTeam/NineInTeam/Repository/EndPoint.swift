//
//  EndPoint.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/05.
//

protocol EndpointUrlProtocol {
    func urlString() -> String
}

enum EndPoint: EndpointUrlProtocol {
    
    case none
    
    func urlString() -> String {
        switch self {
        case .none:
            return ""
        }
    }
    
}

extension EndPoint {

    enum GET: EndpointUrlProtocol {
        
        case join
        case logout
        
        func urlString() -> String {
            switch self {
            case .join:
                return "join"
            case .logout:
                return "logout"
            }
        }
        
    }
    
    enum POST: EndpointUrlProtocol {
        
        case loginWithKakao
        case writeTeam(Int)

        func urlString() -> String {
            switch self {
            case .loginWithKakao:
                return "login-with-kakao"
            case .writeTeam(let teamId):
                return "team/\(teamId)"
            }
        }
        
    }
    
    enum PUT: EndpointUrlProtocol {
        
        case updateProfile(Int)
        
        func urlString() -> String {
            switch self {
            case .updateProfile(let userId):
                return "account/\(userId)"
            }
        }
        
    }
    
}
