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
        VStack {
            Spacer()
            
            TextWithFont(text: title, font: .regular, size: 14)
                .padding(.vertical, 14)
                .padding(.horizontal, 16)
                .foregroundColor(
                    Color.init(hexcode: "FFFFFF")
                )
                .padding(5)
                .background(
                    Color.init(hexcode: "000000")
                        .opacity(0.12)
                    )
                .cornerRadius(10)
        }        
    }
    
}
