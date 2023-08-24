//
//  UrlType.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/10.
//

enum UrlType {
    
    case testServer

    private static var localhost = true

    func get() -> String {
        switch UrlType.localhost {
        case true:
            return "https://9in.team/"
            // return "https://9inteam.heon.dev/"
        case false:
            return "http://127.0.0.1/"
        }
    }
    
}
