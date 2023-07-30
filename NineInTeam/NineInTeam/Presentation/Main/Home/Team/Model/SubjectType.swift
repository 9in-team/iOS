//
//  SubjectType.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/07/30.
//

import Foundation

enum SubjectType: Int, Codable, CaseIterable {
    case project = 0
    case study = 1
    
    var title: String {
        switch self {
        case .project:
            return "PROJECT"
        case .study:
            return "Study"
        }
    }
}
