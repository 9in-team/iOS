//
//  Error.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/19.
//

import Foundation

extension Error {
    
    func printAndTypeCatch(location: String = #function) {
        print("❗️DEBUG -> (\(location)) \(errorTypeDescription): \(self.localizedDescription)")
    }
    
    private var errorTypeDescription: String {
        switch self {
        case is NetworkError:
            return "Network Error"
        case is DecodingError:
            return "Decoding Error"
        case is URLError:
            return "URL Error"
        default:
            return "Unknown Error"
        }
    }
    
}
