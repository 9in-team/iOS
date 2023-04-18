//
//  Resume.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/19.
//

struct Resume: Codable {
    
    var applyState: ApplyState
    
}

enum ApplyState: Codable {
    
    case waiting
    case invited
    case rejected
    
}
