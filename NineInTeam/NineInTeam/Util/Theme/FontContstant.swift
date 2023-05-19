//
//  FontContstant.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/05/19.
//

import Foundation
import SwiftUI

enum FontConstant: String {

    case robotoRegular = "Roboto-Regualr"
    case robotoMedium = "Roboto-Medium"
    case robotoBold = "Roboto-Bold"
    case godoB = "GodoB"

    func font(ofSize size: CGFloat = 16) -> Font {
        return Font.custom(self.rawValue, size: size)
    }
}
