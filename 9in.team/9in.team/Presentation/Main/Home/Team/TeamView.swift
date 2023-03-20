//
//  TeamView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/07.
//

import SwiftUI

struct TeamView: View {

    let team: Team
    
}

extension TeamView {
    
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
                            .fill(Color.init(hexcode: "000000")
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
