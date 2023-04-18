//
//  TeamCellView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/07.
//

import SwiftUI

struct TeamCellView: View {

    let team: Team
    
}

extension TeamCellView {
    
    var body: some View {
        VStack {
            HStack {
                TextWithFont(text: team.subject, font: .regular, size: 16)
                    .foregroundColor(
                        Color(hexcode: "000000")
                            .opacity(0.87)
                    )
                
                Spacer()
                
                TextWithFont(text: "스터디", font: .regular, size: 13)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 10)
                    .foregroundColor(
                        Color(hexcode: "000000")
                            .opacity(0.87)
                    )
                    .background(
                        Capsule(style: .continuous)
                            .fill(Color(hexcode: "000000")
                                .opacity(0.08)
                            )
                    )
            }
            
            Spacer()
            
            HStack {
                ForEach(team.hashtags, id: \.self) { hashtag in
                    TextWithFont(text: hashtag, font: .regular, size: 13)
                        .foregroundColor(
                            Color(hexcode: "000000")
                                .opacity(0.87)
                        )
                        .padding(.vertical, 3)
                        .padding(.horizontal, 10)
                        .background(
                            Capsule(style: .continuous)
                                .stroke(Color(hexcode: "000000")
                                    .opacity(0.24)
                                )
                        )
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 3) {
                    TextWithFont(text: team.leader, font: .regular, size: 12)
                        .foregroundColor(
                            Color(hexcode: "000000")
                        )
                    
                    TextWithFont(text: team.lastModified, font: .regular, size: 12)
                        .foregroundColor(
                            Color(hexcode: "000000")
                                .opacity(0.38)
                        )
                }
            }
        }
        .padding()
        .frame(height: 120)
        .rectangleShadows(firstX: 0, firstY: 1, secondX: 0, secondY: 3)        
        .padding(.bottom, 5)
        .padding(.horizontal, 10)
    }
    
}