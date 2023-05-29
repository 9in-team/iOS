//
//  Shadow.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/04/30.
//

import SwiftUI

struct Shadow: Hashable {
    
    enum ShadowColor {
        case black
        case white
        case lightGray
    }
    
    let color: ShadowColor
    var opacity: CGFloat = 1
    var radius: CGFloat = 0
    var blur: CGFloat = 0
    var locationX: CGFloat = 0
    var locationY: CGFloat = 0
    
    func getColor() -> Color {
        switch color {
        case .black:
            return Color(hexcode: "000000").opacity(opacity)
        case .white:
            return Color(hexcode: "FFFFFF").opacity(opacity)
        case .lightGray:
            return Color(hexcode: "E0E0E0").opacity(opacity)
        }
    }
    
}
