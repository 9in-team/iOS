//
//  BaseButton.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/07/30.
//

import SwiftUI

struct BaseButton: View {
    
    let title: String
    let imageName: String?
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 4)
                .fill(ColorConstant.main.color())
                .frame(height: 42)
                .overlay(
                    HStack(spacing: 11) {
                        if let imageName = imageName {
                            Image(imageName)
                                .resizable()
                                .frame(width: 18, height: 13)
                        }
                        
                        TextWithFont(text: title, font: .robotoMedium, size: 15)
                            .foregroundColor(Color(hexcode: "FFFFFF"))
                    }
                )
                .rectangleShadows(cornerRadius: 4,
                                  [Shadow(color: .black, opacity: 0.12, radius: 5, locationX: 0, locationY: 1),
                                   Shadow(color: .black, opacity: 0.14, radius: 2, locationX: 0, locationY: 2),
                                   Shadow(color: .black, opacity: 0.2, radius: 3, locationX: 0, locationY: 1)])
        }
    }
}

struct BaseButton_Previews: PreviewProvider {
    static var previews: some View {
        BaseButton(title: "title", imageName: "person") {
            
        }
    }
}
