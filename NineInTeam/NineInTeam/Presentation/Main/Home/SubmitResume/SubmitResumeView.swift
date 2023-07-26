//
//  SubmitResumeView.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/07/19.
//

import SwiftUI

struct SubmitResumeView: View {

    @EnvironmentObject var coordinator: Coordinator
    
    @StateObject var viewModel = SubmitResumeViewModel()
    
    // <- 해당 화면에 들어올 때 pk 값으로 디테일값을 다시 조회하는게 나은지 고민 다시 조회한다면 viewModel 에서 참조
    let teamDetail: TeamDetail
    
}

extension SubmitResumeView {
    
    var body: some View {
        BaseView(appState: viewModel.appState, coordinator: coordinator) {
            mainBody()
                .showNavigationBar(NavigationBar(coordinator: coordinator,
                                                 useDismissButton: true,
                                                 title: "지원하기"))
        }
        .onAppear {
            
        }
    }
    
    func mainBody() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 30) {
                teamSubject()
                
                recruitmentRole()
                
//                submissionForm()
            }
            .padding(.horizontal, 20)
        }
    }
    
    func teamSubject() -> some View {
        TextWithFont(text: teamDetail.subject, font: .robotoMedium, size: 20)
            .foregroundColor(
                Color(hexcode: "000000")
                    .opacity(0.87)
            )
    }
    
    func recruitmentRole() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            TextWithFont(text: "모집 역할", font: .robotoBold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
            
            HStack {
                ForEach(teamDetail.roles, id: \.self) { role in
                    roleCell(role: role)
                }
            }
        }
    }
    
    func roleCell(role: RecruitmentRole) -> some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()

            TextWithFont(text: role.title, font: .robotoMedium, size: 20)
                .frame(height: 60, alignment: .top)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.87)
                )
                .lineSpacing(5)
                .multilineTextAlignment(.center)

            TextWithFont(text: "\(role.count)명", font: .robotoMedium, size: 20)
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
    
    func submissionForm() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            TextWithFont(text: "지원 양식", font: .robotoBold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
            
            VStack(spacing: 20) {
                ForEach(teamDetail.applyTemplate, id: \.self) { form in
                    HStack(spacing: 8) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color(hexcode: "000000")
                                    .opacity(0.23)
                                )
                                .frame(width: 62, height: 62)
                                .overlay(
                                    TextWithFont(text: "\(form.number ?? 0)", font: .robotoMedium, size: 12)
                                        .foregroundColor(Color(hexcode: "FFFFFF"))
                                        .padding(6)
                                        .background(ColorConstant.main.color())
                                        .clipShape(Circle())
                                        .offset(x: -31, y: -31)
                                )
                            
                            VStack(spacing: 5) {
                                Image(form.type.asset())
                                    .resizable()
                                    .frame(width: form.type.assetSize().width, height: form.type.assetSize().height)
                                    .padding(.top, 3)
                                
                                TextWithFont(text: form.type.text(), size: 12)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            TextWithFont(text: form.question, size: 16)
                                .foregroundColor(
                                    Color(hexcode: "000000")
                                        .opacity(0.6)
                                )
                                      
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
                    
                    answer(type: form.type)
                        .padding(.bottom, 20)
                }
            }
            .padding(.horizontal, 5)
        }
    }
    
    func answer(type: SubmissionFormType) -> some View {
        VStack {
            switch type {
            case .text:
                Text("text")
            case .image:
                Text("image")
            case .file:
                Text("file")
            case .choice:
                Text("choice")
            }
        }
    }
    
}
