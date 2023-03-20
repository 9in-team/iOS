//
//  SubscribeView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/19.
//

import SwiftUI

struct SubscribeView: View {

    let subscribe: Subscribe
    
}

extension SubscribeView {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Spacer()
                
                TextWithFont(text: "알고리즘 스터디원 구합니다", font: .regular, size: 16)
                    .foregroundColor(
                        Color.init(hexcode: "000000")
                            .opacity(0.87)
                    )
                
                TextWithFont(text: "김진홍", font: .regular, size: 12)
                    .frame(height: 20)
                    .foregroundColor(Color.init(hexcode: "000000"))
                                
                Spacer()
            }
            .padding(.vertical, 3)
            
            Spacer()
 
            VStack(alignment: .trailing) {
                TextWithFont(text: "#알고리즘", font: .regular, size: 13)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 10)
                    .foregroundColor(
                        Color(hexcode: "000000")
                            .opacity(0.87)
                    )
                    .background(
                        Capsule(style: .continuous)
                            .fill(Color.init(hexcode: "000000")
                                .opacity(0.08)
                            )
                    )
                
                TextWithFont(text: "1시간 전", font: .regular, size: 12)
                    .frame(height: 20)
                    .foregroundColor(
                        Color.init(hexcode: "000000")
                            .opacity(0.38)
                    )
                    .padding(.trailing, 8)
            }
        }
        .padding(.vertical, 10)
        .padding(.leading, 13)
        .padding(.trailing, 10)
        .frame(height: 70)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white)
                    .shadow(color: Color.init(hexcode: "000000").opacity(0.12), radius: 5, x: 0, y: 1)
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white)
                    .shadow(color: Color.init(hexcode: "000000").opacity(0.14), radius: 5, x: 0, y: 3)
            }
            )
        .padding(.bottom, 5)
        .padding(.horizontal, 10)
    }
    
}
