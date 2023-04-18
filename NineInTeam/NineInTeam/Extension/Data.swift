//
//  Data.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/13.
//

import Foundation

extension Data {
    
    public var base64: String {
        return self.base64EncodedString(options: .lineLength64Characters)
    }
    
}
