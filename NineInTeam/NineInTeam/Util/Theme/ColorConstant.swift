//
//  ColorConstant.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/06.
//

import SwiftUI

enum ColorConstant: String {
    
    case primary = "1976D2"    
    case secondary = "42A5F5"
    case white = "FFFFFF"
    case black = "000000"
    case kakaoContainer = "FEE500"
    
    func color() -> Color {
        return Color(hexcode: self.rawValue)
    }
    
}
