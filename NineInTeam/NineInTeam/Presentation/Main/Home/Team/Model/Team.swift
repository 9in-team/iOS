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
    var templates: [TeamTemplate]
    var hashtags: [HashTag]
    var type: SubjectType
    var requiredRoles: [Role]
    
    // TODO: teamId로 리더 이름 불러오기
    func getLeaderId() -> String {
        return ""
    }
    
    private enum CodingKeys: String, CodingKey {
        case teamId, subject, openChatUrl
        case templates = "teamTemplates"
        case hashtags = "types"
        case type = "subjectType"
        case requiredRoles = "roles"
    }
    
}
