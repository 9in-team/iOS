//
//  Team.swift
//  9in.team
//
//  Created by ์กฐ์ํ on 2023/03/07.
//

import Foundation

struct Team: Codable {
    
    var teamId: Int = 0
    var subject: String = ""
    var leader: String = ""
    var hashtags: [String] = []
    var lastModified: String = ""
    
}
