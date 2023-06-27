//
//  KeychainError.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/28.
//

import Foundation

enum KeychainError: Error {
    case saveError(Error)
    case updateError
    case readError
    case readDataConvertError
}
