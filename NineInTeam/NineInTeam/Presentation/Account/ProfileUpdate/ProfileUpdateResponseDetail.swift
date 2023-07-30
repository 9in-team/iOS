//
//  ProfileUpdateResponseDetail.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/20.
//

import Foundation

struct ProfileUpdateResponseDetail: Codable {
    let nickname: String
    let imageUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case nickname
        case imageUrl = "imageId"
    }
}
