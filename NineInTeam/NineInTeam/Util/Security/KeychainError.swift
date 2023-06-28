//
//  KeychainError.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/28.
//

import Foundation

enum KeychainError: Error {
    
    case saveError
    case updateError
    case readError
    case readDataConvertError
    
    var localizedDescription: String {
        switch self {
        case .saveError:
            return "키체인 데이터 저장 에러"
        case .updateError:
            return "키체인 데이터 업데이트 에러"
        case .readError:
            return "키체인 데이터 읽기 에러"
        case .readDataConvertError:
            return "키체인 데이터를 읽었으나 데이터 타입 변환 에러"
        }
    }
    
}
