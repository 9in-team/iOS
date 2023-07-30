//
//  HeaderType.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/13.
//

import Foundation

enum HeaderType {
    
    case none
    case test
    case testJWT(token: String)
    case testJWTData(token: Data)

    func get() -> [String: String] {
        switch self {
        case .none:
            return [:]
        case .test:
            return ["Content-Type": "application/json"]
        case .testJWT(let token):
            return ["Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer \(token)"]
        case .testJWTData(let token):
            return ["Authorization": "Bearer \(token)"]

        }
    }
    
}
