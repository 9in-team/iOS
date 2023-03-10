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
                Text(team.subject)
                    .font(.system(size: 16))
                    .foregroundColor(Color(hexcode: "000000").opacity(0.87))
                
                Spacer()
                
                Text("스터디")
                    .padding(.vertical, 7)
                    .padding(.horizontal, 10)
                    .background(Capsule(style: .continuous).fill(Color.init(hexcode: "000000").opacity(0.08)))
                    .font(.system(size: 13))
                    .foregroundColor(Color(hexcode: "000000").opacity(0.87))
            }
            
            Spacer()
            
            HStack {
                ForEach(team.hashtags, id: \.self) { hashtag in
                    Text(hashtag)
                        .padding(.vertical, 3)
                        .padding(.horizontal, 10)
                        .background(Capsule(style: .continuous).stroke(Color(hexcode: "000000").opacity(0.24)))
                        .font(.system(size: 13))
                        .foregroundColor(Color(hexcode: "000000").opacity(0.87))
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(team.leader)
                        .font(.system(size: 12))
                    
                    Text(team.lastModified)
                        .font(.system(size: 12))
                        .foregroundColor(Color(hexcode: "000000").opacity(0.38))
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
        .padding(.bottom, 10)
        .padding(.horizontal, 5)
    }
    
}
