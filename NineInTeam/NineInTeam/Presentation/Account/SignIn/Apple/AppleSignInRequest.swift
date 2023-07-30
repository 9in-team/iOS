//
//  AppleSignInRequest.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/07/17.
//

import Foundation

struct AppleSignInRequest: Codable {
    
    let state: String?
    let code: Data?
    let idToken: Data?
    let user: String?
    
    private enum CodingKeys: String, CodingKey {
        case state, code, user
        case idToken = "id_token"
    }

}
