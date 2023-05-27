//
//  SubmissionForm.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/24.
//

struct SubmissionForm: Hashable, Decodable {
    
    var no: Int?
    var type: SubmissionFormType
    var question: String
    var options: [String]?
    
}
