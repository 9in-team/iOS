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

    let teamId: Int
}

extension TeamDetailView {
    
    var body: some View {
        BaseView(appState: viewModel.appState, coordinator: coordinator) {
            mainBody()
                .showNavigationBar(NavigationBar(coordinator: coordinator,
                                                 useDismissButton: true,
                                                 title: viewModel.teamDetail?.subject ?? ""))
        }
        .onAppear {
            viewModel.requestDetailPage(teamId: teamId)
        }
    }
    
    func mainBody() -> some View {
        ZStack {

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    teamDetailInfo()

                    recruitmentRole()

                    teamExplanation()
                }
                .padding(.horizontal, 20)
            }

            bottomButtons()
        }
    }
    
    func teamDetailInfo() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                TextWithFont(text: "스터디", size: 13)
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
                
                TextWithFont(text: viewModel.teamDetail?.lastModified ?? "", size: 12)
                    .foregroundColor(
                        Color(hexcode: "000000")
                            .opacity(0.6)
                    )
            }
            
            Rectangle()
                .frame(height: 10)
                .foregroundColor(Color.clear)

            TextWithFont(text: team.teamDetail?.subject ?? "", font: .robotoMedium, size: 20)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.87)
                )
            
            Rectangle()
                .frame(height: 5)
                .foregroundColor(Color.clear)
            
            HStack {
                ForEach(viewModel.teamDetail?.hashtags ?? [], id: \.self) { hashtag in
                    TextWithFont(text: "#\(hashtag)", font: .robotoMedium, size: 13)
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
            TextWithFont(text: "모집 역할", font: .robotoBold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
            
            HStack {
                if let team = viewModel.teamDetail {
                    ForEach(team.roles, id: \.self) { role in
                        roleCell(role: role)
                    }
                }
            }
        }
    }

    func roleCell(role: RecruitmentRole) -> some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()

            TextWithFont(text: role.title, font: .medium, size: 20)
                .frame(height: 60, alignment: .top)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.87)
                )
                .lineSpacing(5)
                .multilineTextAlignment(.center)

            TextWithFont(text: "\(role.count)명", font: .medium, size: 20)
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
    
    func teamExplanation() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            TextWithFont(text: "팀 설명", font: .robotoBold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
                                    
            VStack(alignment: .leading, spacing: 5) {
                TextWithFont(text: viewModel.teamDetail?.content ?? "", size: 16)
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
        VStack {
            Spacer()

            floatingButtons()
                .padding([.trailing, .bottom], 14)
            applyButton()
                .padding(.horizontal, 20)
        }
    }
    
    func floatingButtons() -> some View {
        HStack(spacing: 14) {

            Spacer()

            VStack(spacing: 8) {
                Circle()
                    .frame(width: 56, height: 56)
                    .foregroundColor(
                        Color(hexcode: "1565C0")
                    )
                    .circleShadows([Shadow(color: .black, opacity: 0.12, radius: 18, locationY: 1),
                                    Shadow(color: .black, opacity: 0.14, radius: 10, locationY: 6),
                                    Shadow(color: .black, opacity: 0.2, radius: 5, locationY: 3)])
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
                    .circleShadows([Shadow(color: .black, opacity: 0.12, radius: 18, locationY: 1),
                                    Shadow(color: .black, opacity: 0.14, radius: 10, locationY: 6),
                                    Shadow(color: .black, opacity: 0.2, radius: 5, locationY: 3)])
                    .overlay(
                        Image("Like")
                            .resizable()
                            .frame(width: 20, height: 18)
                    )
            }

        }
    }

    func applyButton() -> some View {
        Button {
           //
        } label: {
            RoundedRectangle(cornerRadius: 4)
                .fill(ColorConstant.main.color())
                .frame(height: 42)
                .overlay(
                    TextWithFont(text: "지원하기", font: .robotoMedium, size: 15)
                        .foregroundColor(Color(hexcode: "FFFFFF"))
                )
                .rectangleShadows([Shadow(color: .black, opacity: 0.12, radius: 5, locationX: 0, locationY: 1),
                   Shadow(color: .black, opacity: 0.14, radius: 2, locationX: 0, locationY: 2),
                   Shadow(color: .black, opacity: 0.2, radius: 1, locationX: 0, locationY: 3)])
        }
    }
    
}

#if DEBUG
struct TeamDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailView(teamId: 0)
    }
}
#endif
