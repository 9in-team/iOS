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
                TextWithFont(text: team.subject, size: 16)
                    .foregroundColor(
                        Color(hexcode: "000000")
                            .opacity(0.87)
                    )
                
                Spacer()
                
                TextWithFont(text: "스터디", size: 13)
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
                    TextWithFont(text: "#\(hashtag)", size: 13)
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
                    TextWithFont(text: team, size: 12)
                        .foregroundColor(
                            Color(hexcode: "000000")
                        )
                    
                    TextWithFont(text: team.lastModified, size: 12)
                        .foregroundColor(
                            Color(hexcode: "000000")
                                .opacity(0.38)
                        )
                }
            }
        }
        .padding()
        .frame(height: 120)
        .rectangleShadows([Shadow(color: .black, opacity: 0.12, radius: 8, locationX: 0, locationY: 1),
                           Shadow(color: .black, opacity: 0.14, radius: 4, locationX: 0, locationY: 3),
                           Shadow(color: .black, opacity: 0.2, radius: 3, locationX: 0, locationY: 3)])
        .padding(.bottom, 5)
    }
    
}

#if DEBUG
struct TeamCellView_Previews: PreviewProvider {
    static var previews: some View {

        let team = TestObject.team
        TeamCellView(team: team)

    }
}
#endif
