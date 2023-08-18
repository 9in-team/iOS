//
//  WritePostResponse.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/08/10.
//

import Foundation

struct WritePostResponse: Decodable {
    
    let detail: Team
    let errorMessage: String?
    
}
