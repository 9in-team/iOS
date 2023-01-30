//
//  HeaderType.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/13.
//

import Foundation

enum HeaderType {
    
    case none
    
    func getHeader() -> [String: String] {
        switch self {
        case .none:
            return [:]
        }
    }
    
}
