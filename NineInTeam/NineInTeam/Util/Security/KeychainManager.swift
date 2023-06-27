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
    
    private func createData(data: String, service: KeychainServiceType, account: String) -> Result<Void, Error> {
        let targetData = Data(data.utf8)
        
        let query = [
            kSecValueData: targetData, // 암호화할 데이터
            kSecClass: kSecClassGenericPassword, // 데이터의 유형
            kSecAttrService: service.rawValue,
            kSecAttrAccount: account
        ] as CFDictionary
        
        let result = SecItemAdd(query, nil)
        
        if result == errSecSuccess {
            return Result.success(())
        } else {
            // 이미 존재하는 데이터 있는 경우 업데이트 쿼리 작업
            do {
                return try updateData(targetData, query: query)
            } catch {
                return .failure(KeychainError.saveError(error))
            }
        }
    }
    
    private func updateData(_ data: Data, query: CFDictionary) throws -> Result<Void, Error> {
        let targetData = [kSecValueData: data] as CFDictionary
        
        let result = SecItemUpdate(query, targetData)
        
        if result == errSecSuccess {
            return Result.success(())
        } else {
            return Result.failure(KeychainError.updateError)
        }
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

extension KeychainManager {
    
    func saveToken(_ token: String, signInProvider: SignInProviderType, tokenType: KeychainServiceType) throws {
        let savedResult = createData(data: token, service: tokenType, account: signInProvider.rawValue)
        switch savedResult {
        case .success(_):
            break
        case .failure(let error):
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
