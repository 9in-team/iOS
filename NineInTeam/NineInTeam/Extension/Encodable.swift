//
//  Encodable.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/19.
//

import Foundation

extension Encodable {
    
    func toDictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        
        guard let dictionary = jsonObject as? [String: Any] else {
            throw CustomEncodingError.invalidData
        }
        
        return dictionary
    }
    
}
