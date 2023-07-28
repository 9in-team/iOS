//
//  SubmitResumeView.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/07/19.
//

import SwiftUI

struct SubmitResumeView: View {

    @StateObject var coordinator = Coordinator()
    
    @StateObject var viewModel = SubmitResumeViewModel()
    
    // <- 해당 화면에 들어올 때 pk 값으로 디테일값을 다시 조회하는게 나은지 고민 다시 조회한다면 viewModel 에서 참조
    let teamDetail: TeamDetail
    
    @State var text: String = ""
    @State var image: String = ""
    @State var file: String = ""
    @State var choice: String = ""
    
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
                
                submissionForm()
                
                submitButton()
            }
            .padding(.horizontal, 20)
        }
    }
    
    func teamSubject() -> some View {
        HStack {
            TextWithFont(text: teamDetail.subject, font: .robotoMedium, size: 24)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.87)
                )
            
            Spacer()
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
                    
                    answer(type: form.type, options: form.options)
                        .padding(.bottom, 10)
                }
            }
            .padding(.horizontal, 5)
        }
    }
    
    func answer(type: SubmissionFormType, options: [String]? = nil) -> some View {
        VStack(alignment: .leading) {
            switch type {
            case .text:
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(hexcode: "000000")
                            .opacity(0.23)
                        )
                    
                    TextWithFont(text: "답변", font: .robotoBold, size: 12)
                        .foregroundColor(
                            Color(hexcode: "000000")
                                .opacity(0.6)
                        )
                        .padding(.horizontal, 5)
                        .background(
                            Rectangle()
                                .fill(Color(hexcode: "FFFFFF"))
                        )
                        .offset(x: 12, y: -5)
                    
                    ScrollView {
                        TextField("답변", text: $text)
                            .font(.system(size: 16))
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 12)
                }
                .frame(maxWidth: .infinity)
            case .image:
                Button {
                    // TODO: Choice Image
                } label: {
                    Rectangle()
                        .fill(Color(hexcode: "D9D9D9"))
                        .frame(height: 93)
                        .overlay {
                            Image("Image")
                                .frame(width: 24, height: 24)
                        }
                }
            case .file:
                VStack(alignment: .leading, spacing: 14) {
                    // TODO:  ForEach
                    HStack {
                        Image("File")
                            .resizable()
                            .frame(width: 16, height: 20)

                        TextWithFont(text: "포트폴리오.pdf", size: 14)
                    }
                    .padding(.leading, 10)
                    
                    
                    Button {
                        // TODO: Choice File
                    } label: {
                        Circle()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color(hexcode: "E0E0E0"))
                            .overlay {
                                Image("Plus")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                            }
                    }
                    .padding(.leading, 6)
                }
            case .choice:
                VStack(spacing: 0) {
                    ForEach(options ?? [], id: \.self) { option in
                        Button {
                            choice = option
                        } label: {
                            HStack(spacing: 0) {
                                Rectangle()
                                    .fill(.clear)
                                    .frame(width: 42, height: 42)
                                    .overlay {
                                        if choice == option {
                                            Image("Choice")
                                                .resizable()
                                                .frame(width: 18, height: 18)
                                        } else {
                                            Image("NotChecked")
                                                .resizable()
                                                .frame(width: 18, height: 18)
                                        }
                                    }
                                
                                TextWithFont(text: option, size: 14)
                                    .foregroundColor(Color(hexcode: "000000")).opacity(0.87)
                                
                                Spacer()
                            }
                        }
                        .frame(height: 42)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    func submitButton() -> some View {
        VStack(spacing: 5) {
            TextWithFont(text: "제출 후 수정 및 삭제 불가능합니다.", size: 12)
            
            Button {
                
            } label: {
                RoundedRectangle(cornerRadius: 4)
                    .fill(ColorConstant.main.color())
                    .frame(height: 42)
                    .overlay(
                        HStack(spacing: 11) {
                            Image("Check")
                                .resizable()
                                .frame(width: 18, height: 18)
                            
                            TextWithFont(text: "지원서 제출", font: .robotoMedium, size: 15)
                                .foregroundColor(Color(hexcode: "FFFFFF"))
                        }
                    )
                    .rectangleShadows([Shadow(color: .black, opacity: 0.12, radius: 5, locationX: 0, locationY: 1),
                                       Shadow(color: .black, opacity: 0.14, radius: 2, locationX: 0, locationY: 2),
                                       Shadow(color: .black, opacity: 0.2, radius: 1, locationX: 0, locationY: 3)])
            }
        }
    }
    
}
