//
//  UserUpdateApiModel.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/20.
//

import Foundation

struct UserProfileUpdateDao: Codable {
    let nickname: String
    let imageUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case nickname
        case imageUrl = "imageId"
    }
}
