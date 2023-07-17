//
//  AppleAuthError.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/07/17.
//

import Foundation

enum AppleAuthError: Error {
    
    case tokenIsNil
    case jsonEncodeFailure
    case jsonIsNil
    
}
