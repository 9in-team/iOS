//
//  URL.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/08/19.
//

import Foundation

extension URL {
    func toData() -> Data? {
        do {
            return try Data(contentsOf: self)
        } catch let error {            
            return nil
        }
    }
}
