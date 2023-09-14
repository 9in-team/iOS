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
        ZStack {
            VStack {
                subjectAndType()
                
                Spacer()
                
                hashTagLabel()
                
                Spacer()
                
                leaderAndDateView()
            }
            .padding()
            
        }
        .background(background)
        .frame(height: 120)
        .padding(.bottom, 5)
        
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.clear)
            .rectangleShadows(cornerRadius: 12,
                              [Shadow(color: .black, opacity: 0.12, radius: 8, locationX: 0, locationY: 1),
                               Shadow(color: .black, opacity: 0.14, radius: 4, locationX: 0, locationY: 3),
                               Shadow(color: .black, opacity: 0.2, radius: 3, locationX: 0, locationY: 3)])
    }
    
    private func subjectAndType() -> some View {
        HStack {
            TextWithFont(text: team.subject, size: 16)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.87)
                )
            
            Spacer()
            
            TextWithFont(text: team.type.title, size: 13)
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
    }
    
    private func hashTagLabel() -> some View {
        HStack {
            ForEach(team.hashtags, id: \.self) { hashtag in
                TextWithFont(text: "#\(hashtag.name)", size: 13)
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
        }
    }
    
    private func leaderAndDateView() -> some View {
        // 리더 이름
        VStack(alignment: .trailing, spacing: 3) {
            TextWithFont(text: team.getLeaderId(), size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                )
            
            TextWithFont(text: "team.lastModified", size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.38)
                )
        }

    }
    
}

#if DEBUG
struct TeamCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        TeamCellView(team: TestObject.team)
    }
    
}
#endif
