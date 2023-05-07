//
//  TeamDetailView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/10.
//

import SwiftUI

struct TeamDetailView: View {
    
    @StateObject var coordinator = Coordinator()

    @StateObject var viewModel = HomeViewModel()
    
    let team: Team
    
}

extension TeamDetailView {
    
    var body: some View {
        BaseView(appState: viewModel.appState, coordinator: coordinator) {
            mainBody()
                .showNavigationBar(NavigationBar(coordinator: coordinator,
                                                 useDismissButton: true,
                                                 title: team.subject))
        }
    }
    
    func mainBody() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 30) {
                teamDetailInfo()
                
                recruitmentRole()
                    
                teamExplanation()
                
                bottomButtons()
            }
            .padding(.horizontal, 10)
        }
    }
    
    func teamDetailInfo() -> some View {
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
                            .fill(Color(hexcode: "000000")
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
    }
    
    func recruitmentRole() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            TextWithFont(text: "모집 역할", font: .bold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
            
            HStack {
                VStack(alignment: .center, spacing: 0) {
                    Spacer()
                    
                    TextWithFont(text: "프론트엔드 개발자", font: .medium, size: 20)
                        .frame(height: 60, alignment: .top)
                        .foregroundColor(
                            Color(hexcode: "000000")
                                .opacity(0.87)
                        )
                        .lineSpacing(5)
                        .multilineTextAlignment(.center)                    
                    
                    TextWithFont(text: "4명", font: .medium, size: 20)
                        .frame(height: 30)
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
    }
    
    func teamExplanation() -> some View {
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
                    .foregroundColor(
                        Color(hexcode: "000000")
                            .opacity(0.42)
                    )
                    .border(Color(hexcode: "000000").opacity(0.42),
                            width: 1)
            }
        }
    }
    
    func bottomButtons() -> some View {
        VStack(alignment: .trailing, spacing: 14) {
            VStack(spacing: 8) {
                Circle()
                    .frame(width: 56, height: 56)
                    .foregroundColor(
                        Color(hexcode: "1565C0")
                    )
                    .circleShadows(firstX: 0, firstY: 1, secondX: 0, secondY: 6)
                    .overlay(
                        Image("Chat")
                            .resizable()
                            .frame(width: 20, height: 20)
                        )
                
                Circle()
                    .frame(width: 56, height: 56)
                    .foregroundColor(
                        Color(hexcode: "9C27B0")
                    )
                    .circleShadows(firstX: 0, firstY: 1, secondX: 0, secondY: 6)
                    .overlay(
                        Image("Like")
                            .resizable()
                            .frame(width: 20, height: 18)
                    )
            }
            
            Button {
               //
            } label: {
                RoundedRectangle(cornerRadius: 4)
                    .fill(ColorConstant.main.color())
                    .frame(height: 42)
                    .overlay(
                        TextWithFont(text: "지원하기", font: .medium, size: 15)
                            .foregroundColor(Color(hexcode: "FFFFFF"))
                    )
                .rectangleShadows(firstX: 0, firstY: 1, secondX: 0, secondY: 2)
            }
        }
    }
    
}
