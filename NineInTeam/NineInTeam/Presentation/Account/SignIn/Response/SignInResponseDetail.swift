//
//  UserApiModel.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/16.
//

import Foundation

struct SignInResponseDetail: Codable {
    
    let id: Int
    let email: String
    let nickname: String
    let imageUrl: String
    
}
