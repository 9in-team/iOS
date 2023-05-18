//
//  Template.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/05/18.
//

import Foundation

struct Template: Decodable {
    var type: String
    var question: String
    var options: [String]?
}
