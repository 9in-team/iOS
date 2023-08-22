//
//  SubmitButtonStyle.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 8/22/23.
//

import SwiftUI

enum SubmitButtonStyle {

    /// width: 349, height: 48
    case large(color: ColorConstant, font: SubmitButtonFont)
    /// width: 227, height: 42
    case medium(color: ColorConstant, font: SubmitButtonFont)
    
    var backgroundColor: Color {
        switch self {
        case .large(let color, _), .medium(let color, _):
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
    
    var font: SubmitButtonFont {
        switch self {
        case .large(_, let font), .medium(_, let font):
            return font
        }
    }
    
}
