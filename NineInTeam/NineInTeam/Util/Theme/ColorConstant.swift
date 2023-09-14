//
//  ColorConstant.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/06.
//

import SwiftUI

enum ColorConstant: String {
    
    /// #1976D2
    case primary
    /// #42A5F5
    case secondary
    /// #FFFFFF
    case white
    /// #000000
    case black
    /// #000000, opacity 0.6
    case gray
    /// #000000, opacity 0.3
    case lightGray
    case kakaoContainer
    
    func color() -> Color {
        switch self {
        case .primary:
            return Color(hexcode: "1976D2")
        case .secondary:
            return Color(hexcode: "42A5F5")
        case .white:
            return Color(hexcode: "FFFFFF")
        case .black:
            return Color(hexcode: "000000")
        case .gray:
            return Color(hexcode: "000000").opacity(0.6)
        case .lightGray:
            return Color(hexcode: "000000").opacity(0.38)
        case .kakaoContainer:
            return Color(hexcode: "FEE500")
        }
    }
    
}
