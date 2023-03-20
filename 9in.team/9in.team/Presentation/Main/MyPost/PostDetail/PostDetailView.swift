//
//  PostDetailView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/20.
//

import SwiftUI

struct PostDetailView: View {

    let team: Team
    
}

extension PostDetailView {
    
    var body: some View {
        BaseView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            TextWithFont(text: "스터디", font: .regular, size: 13)
                                .foregroundColor(
                                    Color(hexcode: "000000")
                                        .opacity(0.87)
                                )
                                .padding(.vertical, 7)
                                .padding(.horizontal, 10)
                                .background(
                                    Capsule(style: .continuous)
                                        .fill(Color.init(hexcode: "000000")
                                            .opacity(0.08))
                                )
                                .font(.system(size: 13))
                            
                            Spacer()
                            
                            TextWithFont(text: team.lastModified, font: .regular, size: 12)
                                .foregroundColor(
                                    Color(hexcode: "000000")
                                        .opacity(0.6)
                                )
                        }
                        
                        Rectangle()
                            .frame(height: 10)
                            .foregroundColor(Color.clear)
                        
                        TextWithFont(text: team.subject, font: .medium, size: 20)
                            .foregroundColor(
                                Color(hexcode: "000000")
                                    .opacity(0.87)
                            )
                        
                        Rectangle()
                            .frame(height: 5)
                            .foregroundColor(Color.clear)
                        
                        HStack {
                            ForEach(team.hashtags, id: \.self) { hashtag in
                                TextWithFont(text: hashtag, font: .medium, size: 13)
                                    .foregroundColor(
                                        Color(hexcode: "000000")
                                            .opacity(0.87)
                                    )
                                    .padding(.vertical, 7)
                                    .padding(.horizontal, 10)
                                    .background(
                                        Capsule(style: .continuous)
                                            .stroke(Color(hexcode: "000000").opacity(0.26))
                                    )
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        TextWithFont(text: "모집 역할", font: .bold, size: 12)
                            .foregroundColor(
                                Color(hexcode: "000000")
                                    .opacity(0.6)
                            )
                        
                        HStack {
                            // 이거 사용
                            //                        ForEach(team., id: \.self) { _ in
                            //                        }
                            
                            VStack(alignment: .center, spacing: 0) {
                                Spacer()
                                
                                TextWithFont(text: "프론트엔드 개발자", font: .medium, size: 20)
                                    .frame(height: 63)
                                    .foregroundColor(
                                        Color(hexcode: "000000")
                                            .opacity(0.87)
                                    )
                                    .lineSpacing(10)
                                    .multilineTextAlignment(.center)
                                
                                Spacer()
                                
                                TextWithFont(text: "4명", font: .medium, size: 20)
                                    .frame(height: 32)
                                    .foregroundColor(
                                        Color(hexcode: "000000")
                                            .opacity(0.38)
                                    )
                                
                                Spacer()
                            }
                            .frame(width: 120, height: 120)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .strokeBorder(Color(hexcode: "000000").opacity(0.6),
                                                  lineWidth: 1)
                            )
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        TextWithFont(text: "팀 설명", font: .bold, size: 12)
                            .foregroundColor(
                                Color(hexcode: "000000")
                                    .opacity(0.6)
                            )
                                                
                        VStack(alignment: .leading, spacing: 5) {
                            TextWithFont(text: "9in.team", font: .regular, size: 16)
                                .foregroundColor(
                                    Color(hexcode: "000000")
                                        .opacity(0.87)
                                )
                                .lineSpacing(5)
                            
                            Divider()
                                .frame(height: 1)
                        }
                    }
                    
                    VStack(spacing: 8) {
                        HStack {
                            Spacer()
                            
                            ZStack(alignment: .center) {
                                Circle()
                                    .frame(width: 56, height: 56)
                                    .foregroundColor(
                                        Color(hexcode: "1565C0")
                                    )
                                    .background(
                                        ZStack {
                                            Circle()
                                                .fill(Color.clear)
                                                .shadow(color: Color.init(hexcode: "000000").opacity(0.12),
                                                        radius: 5, x: 0, y: 1)
                                            
                                            Circle()
                                                .fill(Color.clear)
                                                .shadow(color: Color.init(hexcode: "000000").opacity(0.14),
                                                        radius: 5, x: 0, y: 6)
                                        }
                                    )
                                
                                Image("Chat")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        
                        HStack {
                            Spacer()
                            
                            ZStack(alignment: .center) {
                                Circle()
                                    .frame(width: 56, height: 56)
                                    .foregroundColor(
                                        Color(hexcode: "9C27B0")
                                    )
                                    .background(
                                        ZStack {
                                            Circle()
                                                .fill(Color.clear)
                                                .shadow(color: Color.init(hexcode: "000000").opacity(0.12),
                                                        radius: 5, x: 0, y: 1)
                                            
                                            Circle()
                                                .fill(Color.clear)
                                                .shadow(color: Color.init(hexcode: "000000").opacity(0.14),
                                                        radius: 5, x: 0, y: 6)
                                        }
                                    )
                                
                                Image("Like")
                                    .resizable()
                                    .frame(width: 20, height: 18)
                            }
                        }
                                                
                        Rectangle()
                            .frame(height: 7)
                            .foregroundColor(Color.clear)
                        
                        Button {
                           //
                        } label: {
                            ZStack {
                                ColorConstant.main.color()
                                
                                TextWithFont(text: "지원하기", font: .regular, size: 20)
                                    .foregroundColor(Color(hexcode: "FFFFFF"))
                            }
                            .frame(height: 50)
                            .cornerRadius(4)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .showNavigationBar(NavigationBar(useDismissButton: true, title: "모집글 수정"))
    }
    
}
