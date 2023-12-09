//
//  ToastView.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/01.
//

import SwiftUI

struct Toast: View {
    
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
}

extension Toast {
    
    var body: some View {
        ZStack {
            TextWithFont(text: title, font: .robotoRegular, size: 14)
                .padding(.vertical, 14)
                .padding(.horizontal, 16)
                .foregroundColor(
                    Color(hexcode: "FFFFFF")
                )
                .frame(maxWidth: UIScreen.screenWidth - 72)
                .cornerRadius(10)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.init(hexcode: "323232"))
                }
        }
        .rectangleShadows(cornerRadius: 10, [
            Shadow.init(color: .black, opacity: 0.12, radius: 9, locationY: 1),
            Shadow.init(color: .black, opacity: 0.14, radius: 5, locationY: 6),
            Shadow.init(color: .black, opacity: 0.20, radius: 2.5, locationY: 3)
        ])
        .offset(y: UIScreen.screenHeight / 4)
    }
    
}

#if DEBUG
struct Toast_Previews: PreviewProvider {
    static var previews: some View {
        Toast(title: "타이틀입니다.")
    }
}
#endif
