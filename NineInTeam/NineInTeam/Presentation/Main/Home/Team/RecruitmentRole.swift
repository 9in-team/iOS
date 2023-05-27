//
//  RecruitmentRole.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/23.
//

struct RecruitmentRole: Hashable, Decodable {
    
    var title: String
    var count: Int

    private enum CodingKeys: String, CodingKey {
        case title = "name"
        case count = "number"
    }
}
