//
//  SubscribeHashtagList.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/06/01.
//

import Foundation

struct SubscribeHashtagList: Decodable {
    var result: String
    var list: [Hashtag]
}
