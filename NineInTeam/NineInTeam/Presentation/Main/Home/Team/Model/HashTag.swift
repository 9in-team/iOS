//
//  HashTag.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/07/30.
//

import Foundation

struct HashTag: Codable, Hashable {
    let name: String
    
    init(_ name: String) {
        self.name = name
    }
}
