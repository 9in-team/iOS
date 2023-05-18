//
//  Team.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/07.
//

struct TeamResponse: Codable {
    var result: String
    var teams: [Team]
}

struct Team: Codable {
    
    var teamId: Int
    var subject: String
    var leader: String
    var hashtags: [String]
    var lastModified: String
    
}
