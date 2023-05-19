//
//  TextWithFont.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/15.
//

import SwiftUI

struct TextWithFont: View {
    
    let text: String
    var font: FontConstant?
    let size: CGFloat

    var body: some View {
        if let font = font {
            Text(text)
                .font(.custom(font, size: size))
        } else {
            Text(text)
                .font(.custom(.robotoRegular, size: size))
        }
    }
    
}
