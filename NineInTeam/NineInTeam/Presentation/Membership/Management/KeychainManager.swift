//
//  KeychainManager.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/18.
//

import Security
import Alamofire
import SwiftUI

final class KeychainManager {
    
    // TODO: 토큰 등 민감정보 저장용 Keychain service 구현
    // [] Service CRUD 작성
    
    @AppStorage("KeychainTest") private var testKakaoToken: String = "" // FIXME: 실운영시 Keychain API로 암호화 해야함

    static let shared = KeychainManager()
    
    private init() {
        
    }
    
}

extension KeychainManager {

    func saveLoginToken(token: String) {
        self.testKakaoToken = token
    }
    
    func getToken() -> String {
        print("DEBUG TOKEN: \(self.testKakaoToken)")
        return self.testKakaoToken
    }
    
}
