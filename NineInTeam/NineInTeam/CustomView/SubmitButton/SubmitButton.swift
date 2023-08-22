//
//  SubmitButton.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/07/30.
//

import SwiftUI

struct SubmitButton: View {
    
    let title: String
    let imageName: String?
    let style: SubmitButtonStyle
    
    init(title: String,
         imageName: String? = nil,
         style: SubmitButtonStyle) {
        self.style = style
        self.title = title
        self.imageName = imageName
    }
    
}

extension SubmitButton {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(style.backgroundColor)
            .frame(width: style.size.width, height: style.size.height)
            .overlay(content(text: title, imageName: imageName))
            .rectangleShadows(cornerRadius: 4, shadows())
    }
    
    private func content(text: String, imageName: String?) -> some View {
        HStack(spacing: 11) {
            if let imageName = imageName {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 24, maxHeight: 24)
            }
            
            TextWithFont(text: text, font: style.font.font, size: style.font.size)
                .foregroundColor(Color(hexcode: "FFFFFF"))
        }
    }
    
    private func shadows() -> [Shadow] {
        return [Shadow(color: .black, opacity: 0.12, radius: 2.5, locationX: 0, locationY: 1),
                Shadow(color: .black, opacity: 0.14, radius: 1, locationX: 0, locationY: 2),
                Shadow(color: .black, opacity: 0.2, radius: 0.5, locationX: 0, locationY: 3)]
    }
    
}

#if DEBUG
struct BaseButton_Previews: PreviewProvider {
    static var previews: some View {
        SubmitButton(title: "지원서 제출",
                     imageName: "Checkmark", 
                     style: .large(color: .primary, font: .normal))
    }
}
#endif
