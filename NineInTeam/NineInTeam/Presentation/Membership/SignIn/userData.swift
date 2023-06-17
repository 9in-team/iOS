//
//  userData.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/16.
//

import Foundation

struct UserData {
    let email: String
    let nickName: String
    let profileImageUrl: String
    var myTeam: [Team]?
    var joinedTeam: [Team]?
}
