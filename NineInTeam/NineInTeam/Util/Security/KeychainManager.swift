//
//  KeychainManager.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/18.
//

// TODO: 토큰 등 민감정보 저장용 Keychain service 구현
// [] Service CRUD 작성

import Security
import Alamofire
import SwiftUI

enum KeychainError: Error {
    case saveError
    case updateError
    case fetchError
}

final class KeychainManager {
    
//    @AppStorage("TokenTest") private var testKakaoToken: String = "" // FIXME: 실 운영시 Keychain API로 암호화 해야함

    static let shared = KeychainManager()
    
    private init() { }
    
}

extension KeychainManager {
//
//    func getToken() -> String {
//        print("DEBUG TOKEN: < \(self.testKakaoToken) >")
//        return self.testKakaoToken
//    }
//    
//    func setToken(_ token: String) {
//        self.testKakaoToken = token
//    }
//    
    func deleteToken() {
//        self.testKakaoToken = ""
        self.delete(account: .kakao)
    }
    
}

extension KeychainManager {
    
    func saveAccessToken(token: String, signInProvider: SignInProviderType) -> Result<Void, Error> {
        let tokenData = Data(token.utf8)
        print("⚙️ DEBUG: KEYCHAIN 저장 시작")

        let query = makeQuery(tokenData, service: "access-token", account: signInProvider.rawValue)
        let result = addSecureItem(query: query)
        
        if result == errSecSuccess {
            print("✅ DEBUG: KEYCHAIN 저장 성공")
            return Result.success(())
        } else {
            let updateResult = updateAccessToken(tokenData, query: query)
            print("❗️ DEBUG: TOKEN SAVE Error -> result: \(result), updateResult: \(updateResult)")

            return updateResult == errSecSuccess
            ? Result.success(())
            : Result.failure(KeychainError.updateError)
        }
    }
    
    private func updateAccessToken(_ data: Data, query: CFDictionary) -> OSStatus {
        let attributesToUpdate = [kSecValueData: data] as CFDictionary
        return SecItemUpdate(query, attributesToUpdate)
    }
    
    func getToken(service: String = "access-token", signInProvider: SignInProviderType) -> String? {
        let fetchedData = read(service: service, account: signInProvider.rawValue)
        
        if let fetchedData = fetchedData {
            let data = String(data: fetchedData, encoding: .utf8)
            print("✅ DEBUG: \(#function) 가져온 토큰 데이터 -> \(data)")
            return data
        } else {
            print("❗️ 가져온 토큰 데이터: 없음")
            return nil
        }
    }
    
}

extension KeychainManager {
    
    /// let accessToken = "dummy-access-token"
    /// let data = Data(accessToken.utf8)
    /// KeychainHelper.standard.save(data, service: "access-token", account: "facebook")
    private func makeQuery(_ data: Data, service: String, account: String) -> CFDictionary  {
        
        // Create query
        return [kSecValueData: data, // 암호화할 데이터
                    kSecClass: kSecClassGenericPassword, // 데이터의 유형
              kSecAttrService: service, // kSecClass 가 kSecClassGenericPassword로 설정된 경우 필수
              kSecAttrAccount: account // kSecClass 가 kSecClassGenericPassword로 설정된 경우 필수
        ] as CFDictionary
    }
    
    private func addSecureItem(query: CFDictionary) -> OSStatus {
        return SecItemAdd(query, nil)
    }
    
    func read(service: String, account: String) -> Data? {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    func delete(service: String = "access-token", account: SignInProviderType) {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        // Delete item from keychain
        SecItemDelete(query)
    }
    
}

// MARK: - Generic Type
extension KeychainManager {
    func save<T>(_ item: T, service: String, account: String) where T: Codable {
        
        do {
            // Encode as JSON data and save in keychain
            let data = try JSONEncoder().encode(item)
            save(data, service: service, account: account)
            
        } catch {
            assertionFailure("Fail to encode item for keychain: \(error)")
        }
    }
    
    func read<T>(service: String, account: String, type: T.Type) -> T? where T: Codable {
        
        // Read item data from keychain
        guard let data = read(service: service, account: account) else {
            return nil
        }
        
        // Decode JSON data to object
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
    
// https://swiftsenpai.com/development/persist-data-using-keychain/
//    struct Auth: Codable {
//        let accessToken: String
//        let refreshToken: String
//    }
//
//    // Create an object to save
//    let auth = Auth(accessToken: "dummy-access-token",
//                     refreshToken: "dummy-refresh-token")
//
//    let account = "domain.com"
//    let service = "token"
//
//    // Save `auth` to keychain
//    KeychainHelper.standard.save(auth, service: service, account: account)
//
//    // Read `auth` from keychain
//    let result = KeychainHelper.standard.read(service: service,
//                                              account: account,
//                                              type: Auth.self)!
//
//    print(result.accessToken)   // Output: "dummy-access-token"
//    print(result.refreshToken)  // Output: "dummy-refresh-token"
    
}
