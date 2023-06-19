//
//  Error.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/06/19.
//

import Foundation

extension Error {
    
    func printAndTypeCatch(location: String = "") {
        if let error = self as? NetworkError {
            print("❗️DEBUG (\(location)) NetworkError:  \(error.localizedDescription)")
        } else if let error = self as? DecodingError {
            print("❗️DEBUG (\(location)) DecodingError:  \(error.localizedDescription)")
        } else if let error = self as? URLError {
            print("❗️DEBUG (\(location)) URLError:  \(error.localizedDescription)")
        } else {
            print("❗️DEBUG (\(location)) 알수없는 에러:  \(self.localizedDescription)")
        }
    }
    
}
