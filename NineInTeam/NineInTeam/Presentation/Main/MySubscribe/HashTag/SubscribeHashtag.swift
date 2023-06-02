//
//  SubscribeHashtag.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/06/01.
//

import Foundation

struct SubscribeHashtag: Decodable, Hashable {
    var type: HashTagType
    var name: String
    var count: Int
    var subscribing: Bool?
}

enum HashTagType: String, Decodable {
    case study, project
}
