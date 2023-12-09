//
//  SubmitButtonFont.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 8/22/23.
//

import Foundation

enum SubmitButtonFont {
    /// Roboto Regular, 20pt
    case normal
    /// Roboto Medium, 15pt
    case small
    
    var size: CGFloat {
        switch self {
        case .normal:
            return 20
        case .small:
            return 15
        }
    }
    
    var font: FontConstant {
        switch self {
        case .normal:
            return .robotoRegular
        case .small:
            return .robotoMedium
        }
    }
}
