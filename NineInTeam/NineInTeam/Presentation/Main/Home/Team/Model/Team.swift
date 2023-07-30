//
//  Team.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/07.
//

struct Team: Codable {
    
    var teamId: Int
    var subject: String
    var openChatUrl: String
    var teamTemplates: [TeamTemplate]
    var types: [HashTag]
    var subjectType: SubjectType
    var roles: [Role]
    
}
