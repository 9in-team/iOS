//
//  PostView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/16.
//

import SwiftUI

struct PostView: View {

    let post: Post
    
}

extension PostView {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Spacer()
                
                TextWithFont(text: "알고리즘 스터디원 구합니다", font: .regular, size: 16)
                    .foregroundColor(
                        Color.init(hexcode: "000000")
                            .opacity(0.87)
                    )
                
                TextWithFont(text: "1시간 전", font: .regular, size: 12)
                    .frame(height: 20)
                    .foregroundColor(
                        Color.init(hexcode: "000000")
                            .opacity(0.38)
                    )
                
                Spacer()
            }
            .padding(.vertical, 3)
            
            Spacer()
            
            ZStack(alignment: .center) {
                Image("Post")
                    .resizable()
                    .frame(width: 20, height: 16)
                
                if post.badge != 0 {
                    VStack {
                        HStack {
                            Spacer()
                            
                            TextWithFont(text: "\(post.badge)", font: .medium, size: 12)
                                .padding(.horizontal, 6)
                                .frame(height: 20)
                                .foregroundColor(Color.init(hexcode: "FFFFFF"))
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.init(hexcode: "9C27B0"))
                                        )
                        }
                        
                        Spacer()
                    }
                }
            }
            .frame(width: 48, height: 48)
        }
        .padding(.vertical, 10)        
        .padding(.leading, 13)
        .padding(.trailing, 7)
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
