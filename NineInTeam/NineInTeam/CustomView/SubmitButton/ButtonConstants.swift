//
//  ButtonConstants.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 8/22/23.
//

import SwiftUI

enum ButtonConstants {

    /// width: 349, height: 48
    case large(color: ColorConstant, font: SubmitButtonFont, imageName: String? = nil)
    /// width: 227, height: 42
    case medium(color: ColorConstant, font: SubmitButtonFont, imageName: String? = nil)
    
    var backgroundColor: Color {
        switch self {
        case .large(let color, _, _), .medium(let color, _, _):
            return color.color()
        }
    }
    
    var size: CGSize {
        switch self {
        case .large:
            return CGSize(width: 349, height: 48)
        case .medium:
            return CGSize(width: 227, height: 42)
        }
    }
    
    var fonts: SubmitButtonFont {
        switch self {
        case .large(_, let font, _), .medium(_, let font, _):
            return font
        }
    }
    
    var imageName: String? {
        switch self {
        case .large(_, _, let name), .medium(_, _, let name):
            return name
        }
    }
    
}
