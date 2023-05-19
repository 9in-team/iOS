//
//  Font.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/05/19.
//

import SwiftUI

extension Font {

    static func custom(_ name: FontConstant, size: CGFloat) -> Font {
        return Font.custom(name.rawValue, size: size)
    }

}
