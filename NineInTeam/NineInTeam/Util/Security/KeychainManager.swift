//
//  KeychainManager.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/18.
//

import Security
import SwiftUI

final class KeychainManager {
    
    static let shared = KeychainManager()
    
    private init() { }
    
}

extension KeychainManager {
    
    private func createData(data: String, service: KeychainServiceType, account: String) throws {
        let targetData = Data(data.utf8)
        
        let query = [
            kSecValueData: targetData, // 암호화할 데이터
            kSecClass: kSecClassGenericPassword, // 데이터의 유형
            kSecAttrService: service.rawValue,
            kSecAttrAccount: account
        ] as CFDictionary
        
        let result = SecItemAdd(query, nil)
        
        if result != errSecSuccess {
            throw KeychainError.saveError
        }
        
    }
    
    private func updateData(data: String, service: KeychainServiceType, account: String) throws {
        
        let targetData = Data(data.utf8)
        print("DEBUG:\(#function) Data\(targetData)")
        
        let query = [
            kSecValueData: targetData, // 암호화할 데이터
            kSecClass: kSecClassGenericPassword, // 데이터의 유형
            kSecAttrService: service.rawValue,
            kSecAttrAccount: account
        ] as CFDictionary
        
        let result = SecItemAdd(query, nil)

        if result != errSecSuccess {
            print("DEBUG:\(#function) Error")
            throw KeychainError.updateError
        }
        
        print("DEBUG:\(#function) 완료")
        
    }
    
    private func readData(service: KeychainServiceType, account: String) throws -> String {
        let query = [
            kSecAttrService: service.rawValue,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        let data: Data? = (result as? Data)
        
        if let data = data {
            if let fetchedDataString = String(data: data, encoding: .utf8) {
                return fetchedDataString
            } else {
                throw KeychainError.readDataConvertError
            }
        } else {
            throw KeychainError.readError
        }
    }
    
    private func delete(service: KeychainServiceType, account: String) {
        let query = [
            kSecAttrService: service.rawValue,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        SecItemDelete(query)
    }
    
}

// Sing In 관련 토큰 암호화
extension KeychainManager {
    
    func saveToken(_ token: String, signInProvider: SignInProviderType, tokenType: KeychainServiceType) throws {
        
        deleteToken(signInProvider: signInProvider)
        
        do {
            try createData(data: token, service: tokenType, account: signInProvider.rawValue)
        } catch {
            throw error
        }

    }
    
    func getToken(signInProvider: SignInProviderType, tokenType: KeychainServiceType) throws -> String {
        do {
            return try readData(service: tokenType, account: signInProvider.rawValue)
        } catch {
            throw KeychainError.readError
        }
    }
    
    func deleteToken(signInProvider: SignInProviderType) {
        self.delete(service: KeychainServiceType.accessToken, account: signInProvider.rawValue)
    }
    
}
