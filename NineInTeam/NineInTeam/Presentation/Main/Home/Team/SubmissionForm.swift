//
//  TeamTemplate.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/24.
//

struct SubmissionForm: Hashable, Codable {
    
    var number: Int?
    var type: TeamTemplateType
    var question: String
    var options: [String]?
    
}
