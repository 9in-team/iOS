//
//  UrlType.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/10.
//

enum UrlType {
    
    case test
    case testLocal
    case testLocal2
    case testDomain
    case kakaoApi

    func get() -> String {
        switch self {
        case .test:
            // return "https://9in.team/"
            return "http://127.0.0.1:8080/"
        case .testLocal:
            return "http://127.0.0.1:8080/"
        case .testLocal2:
            return "http://0.0.0.0:8080/"
        case .testDomain:
            return "https://9inteam.heon.dev/"
        case .kakaoApi:
            return "https://kapi.kakao.com/"
        }
    }
    
}
