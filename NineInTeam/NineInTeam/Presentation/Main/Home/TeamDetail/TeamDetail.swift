//
//  TeamDetail.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/05/18.
//

import Foundation

struct TeamDetail: Decodable {
    var result: String
    var subject: String
    var leaderId: Int
    var hashtags: [String]
    var roles: [Role]
    var content: String
    var applyTemplate: [TeamTemplate]
    var lastModified: String
    var liked: Bool
}
