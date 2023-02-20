//
//  File.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/20.
//

enum TestResponseData {
    
    case SUCCESS
    case ERROR
    
    func getDictionary() -> [String: String] {
        switch self {
        case .SUCCESS:
            return ["result": "SUCCESS",
                    "description": ""]
        case .ERROR:
            return ["result": "ERROR",
                    "description": ""]        
        }
    }
    
}
