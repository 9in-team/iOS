//
//  SignInProviderType.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/18.
//

import Foundation

// apple, none.. 등 로그인 서비스에 따른 분기작업시 사용
enum SignInProviderType: String, Codable {
    case kakao
    case apple
    case notSigned
}
