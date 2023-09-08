//
//  Role.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/23.
//

struct Role: Codable, Hashable {
    
    var title: String
    var count: Int

    private enum CodingKeys: String, CodingKey {
        case title = "name"
        case count = "requiredCount"
    }
}
