//
//  UserData.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/16.
//

import Foundation

struct UserData: Codable {
    let id: Int
    let email: String
    let nickName: String
    let profileImageUrl: String
    var myTeam: [Team] = []
    var joinedTeam: [Team] = []
    let signInProvider: SignInServiceProvider
}
