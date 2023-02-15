//
//  ColorConstant.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/06.
//

import SwiftUI

enum ColorConstant: String {
    
    case _default = "1976D2"
    
    func color() -> Color {
        return Color(hexcode: self.rawValue)
    }
    
}
