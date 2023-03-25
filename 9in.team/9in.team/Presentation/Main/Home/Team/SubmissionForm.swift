//
//  SubmissionForm.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/24.
//

struct SubmissionForm: Hashable {
    
    var no: Int = 1
    var type: SubmissionFormType = .text
    var content: String = ""
    
}
