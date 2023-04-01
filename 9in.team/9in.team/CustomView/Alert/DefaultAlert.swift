//
//  DefaultAlert.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/22.
//

import SwiftUI

struct DefaultAlert: View {
    
    let title: String
    let completion: () -> Void
    
    var body: some View {
        ZStack {
            Color(hexcode: "000000")
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                TextWithFont(text: title, font: nil, size: 16)
                
                Spacer()
                
                VStack(spacing: 0) {
                    Divider()
                    
                    Button {
                        completion()
                    } label: {
                        TextWithFont(text: "확인", font: nil, size: 14)
                            .frame(maxWidth: .infinity)
                    }
                    .frame(height: 60)
                }
            }
            .frame(width: 315, height: 315)
            .background(
                Color(hexcode: "FFFFFF")
            )
            .cornerRadius(20)
            .padding(30)
        }
    }
    
}
