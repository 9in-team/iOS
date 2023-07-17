//
//  KakaoAuthError.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/28.
//

import Foundation

enum KakaoAuthError: Error {

    case unknown
    case tokenIsNil
    case sessionExpired
    case userdataFetchFailure
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "알수없는 카카오 인증 에러"
        case .tokenIsNil:
            return "카카오 인증 토큰이 Nil입니다."
        case .sessionExpired:
            return "카카오 인증 세션이 만료되었습니다."
        case .userdataFetchFailure:
            return "토큰은 유효하지만 카카오 유저 데이터를 가져오지 못했습니다."
        }
    }
    
}
