//
//  ColorConstant.swift
//  9in.team
//
//  Created by ์กฐ์ํ on 2023/02/06.
//

import SwiftUI

enum ColorConstant: String {
    
    case main = "1976D2"
    
    func color() -> Color {
        return Color(hexcode: self.rawValue)
    }
    
}
