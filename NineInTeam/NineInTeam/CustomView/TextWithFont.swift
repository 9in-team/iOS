//
//  TextWithFont.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/15.
//

import SwiftUI

struct TextWithFont: View {
    
    let text: String
    let font: Font.Weight?
    let size: CGFloat
    
    var body: some View {
        if font == nil {
            Text(text)
                .font(.custom("GodoB", size: size))
        } else {
            Text(text)
                .font(.system(size: size))
                .fontWeight(font)                
        }
    }
    
}
