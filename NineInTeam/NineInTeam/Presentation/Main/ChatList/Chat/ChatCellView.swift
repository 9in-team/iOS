//
//  ChatCellView.swift
//  9in.team
//
//  Created by 조상현 on 2023/04/02.
//

import SwiftUI

struct ChatCellView: View {
    
    var chatRoom: ChatRoom
    
}

extension ChatCellView {    
    
    var body: some View {
        HStack(spacing: 0) {
            Circle()
                .frame(width: 40, height: 40)
            
            Spacer()
                .frame(width: 20)
                        
            VStack(alignment: .leading, spacing: 3) {
                TextWithFont(text: "조상현", size: 16)
                               
                TextWithFont(text: chatRoom.recentMessage, font: .robotoMedium, size: 14)
                    .opacity(0.38)
                    .lineLimit(1)
                
                Spacer()
            }
            .foregroundColor(Color(hexcode: "000000"))
            .padding(.top, 22)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 6) {
                TextWithFont(text: "1시간 전", size: 12)
                    .foregroundColor(
                        Color(hexcode: "000000")
                            .opacity(0.38)
                    )
                
                TextWithFont(text: "1", font: .robotoMedium, size: 12)
                    .foregroundColor(Color(hexcode: "FFFFFF"))
                    .padding(6)
                    .background(Circle().fill(ColorConstant.main.color()))
                
                Spacer()
            }
            .padding(.top, 24)
        }
        .frame(height: 90)
        .padding(.leading, 21)
        .padding(.trailing, 23)
        .background(Color(hexcode: "E7E7E7"))
        .cornerRadius(10)
    }
    
}
