//
//  ButtonConstants.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 8/22/23.
//

import SwiftUI

enum ButtonConstants {

    /// width: 349, height: 48
    case fullSize(color: ColorConstant, font: SubmitButtonFont, imageName: String? = nil)
    /// width: 227, height: 42
    case halfSize(color: ColorConstant, font: SubmitButtonFont, imageName: String? = nil)
    
    var backgroundColor: Color {
        switch self {
        case .fullSize(let color, _, _), .halfSize(let color, _, _):
            return color.color()
        }
    }
    
    var size: CGSize {
        switch self {
        case .fullSize:
            return CGSize(width: 349, height: 48)
        case .halfSize:
            return CGSize(width: 227, height: 42)
        }
    }
    
    var fonts: SubmitButtonFont {
        switch self {
        case .fullSize(_, let font, _), .halfSize(_, let font, _):
            return font
        }
    }
    
    var imageName: String? {
        switch self {
        case .fullSize(_, _, let name), .halfSize(_, _, let name):
            return name
        }
    }
    
}
