//
//  TeamResponse.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/07/30.
//

import Foundation

struct TeamResponse: Codable {
    var result: String
    var teams: [Team]
}
