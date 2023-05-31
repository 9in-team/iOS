//
//  Hashtag.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/06/01.
//

import Foundation

struct Hashtag: Decodable, Hashable {
    var name: String
    var count: Int
    var subscribing: Bool?
}
