//
//  WritePostView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/20.
//

import SwiftUI

struct WritePostView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    @State private var isShowAlert: Bool = false
    @State private var anyAlert: AnyView = AnyView(EmptyView())
    @State private var selectedIndex: Int = 0
    @State private var showAddTagAlert: Bool = false
    @State private var showSubmitAlert: Bool = false

    @State var chatRoomLink: String = ""
    
}

extension WritePostView {
    
    var body: some View {
        BaseView(appState: viewModel.appState) {
            mainBody()
                .showNavigationBar(NavigationBar(useDismissButton: true, title: "모집글 작성"))
        }
    }
    
    func mainBody() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 30) {

                Group {
                    radioGroup(selected: $viewModel.subjectType)
                    
                    titleView()
                    
                    tag()
                }
                .padding(.horizontal, 20)

                recruitmentRole()

                Group {
                    teamExplanation()
                    
                    submissionForm()
                    
                    teamChatRoomLink()
                    
                    bottomButton()
                }
                .padding(.horizontal, 20)

            }
            .padding(.bottom, 10)
        }
    }
    
    private func radioGroup(selected: Binding<SubjectType>) -> some View {
        RadioButtonGroups($viewModel.subjectType)
    }
    
    private func titleView() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            TextWithFont(text: "제목", font: .robotoBold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
                .padding(.bottom, 4)
            
            VStack(alignment: .leading, spacing: 5) {
                TextField("제목을 입력하세요.", text: $viewModel.subject)
                    .foregroundColor(
                        Color(hexcode: "000000")
                            .opacity(0.87)
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
    }
    
    private func tagCell(_ tag: HashTag) -> some View {
        TextWithFont(text: tag.name, size: 13)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .foregroundColor(Color(hexcode: "000000"))
            .background(
                Capsule(style: .continuous)
                    .stroke(Color(hexcode: "000000").opacity(0.26))
            )
            .frame(height: 35)
    }
    
    func tag() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            TextWithFont(text: "태그", font: .robotoBold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(viewModel.hashtags, id: \.self) { tag in
                        tagCell(tag)
                    }
                    
                    Button {
                        showAddTagAlert = true
                    } label: {
                        Circle()
                            .frame(width: 28, height: 28)
                            .foregroundColor(Color(hexcode: "E0E0E0"))
                            .overlay {
                                Image("Plus")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                            }
                    }
                    .drawOnRootViewController(isPresented: $showAddTagAlert) {
                        BaseAlert {
                            Text("showAddTagAlert = false")
                        }
                    }
                }
            }
        }
    }
    
    func recruitmentRole() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            TextWithFont(text: "모집 역할", font: .robotoBold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
                .padding(.bottom, 14)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 10, height: 120)

                    ForEach(viewModel.roles, id: \.self) { role in
                        VStack(alignment: .center, spacing: 0) {
                            Spacer()
                            
                            TextWithFont(text: role.name, font: .robotoMedium, size: 20)
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
                         
                    Button {
                        showSubmitAlert = true
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 120, height: 120)
                            .foregroundColor(Color(hexcode: "F5F5F5"))
                            .overlay {
                                Image("Plus")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                    }
                    .drawOnRootViewController(isPresented: $showSubmitAlert) {
                        BaseAlert {
                            Text("showAddRecruitmentRoleAlert = false")
                        }
                    }
                }
            }
        }
    }
    
    func teamExplanation() -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color(hexcode: "000000")
                    .opacity(0.23)
                )
            
            VStack {
                TextWithFont(text: "팀 설명", font: .robotoBold, size: 12)
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
                
                Spacer()
            }
            
            ScrollView {
                // TextField로 변경
                TextWithFont(text: "asdf\nasdfa]nasdfa\nadf\nasdfasd\nasdf", size: 16)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 12)
        }
        .frame(height: 230)
        .frame(maxWidth: .infinity)
    }
    
    func submissionForm() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            TextWithFont(text: "지원 양식", font: .robotoBold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
            
            VStack(spacing: 20) {
                
                // 팀 템플릿
                ForEach(viewModel.templates, id: \.self) { form in

                }
                
                Button {
                    showSubmitAlert = true
                } label: {
                    Circle()
                        .frame(width: 56, height: 56)
                        .foregroundColor(Color(hexcode: "E0E0E0"))
                        .overlay {
                            Image("Plus")
                                .resizable()
                                .frame(width: 14, height: 14)
                        }
                }
                .drawOnRootViewController(isPresented: $showSubmitAlert) {
                    BaseAlert {
                        Text("showAddSubmissionFormAlert = false")
                    }
                }
            }
            .padding(.horizontal, 5)
        }
    }
    
    private func teamTemplateView(_ form: TeamTemplate) -> some View {
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
    }
    
    func teamChatRoomLink() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            TextWithFont(text: "팀 채팅방 링크", font: .robotoBold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
            
            TextWithFont(text: "Slack, 오픈채팅방 등 팀에서 사용할 채팅방 링크를 적어주세요.\n승인 처리한 지원자에게 자동 전달됩니다.",
                         size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
            
            VStack(alignment: .leading, spacing: 5) {
                TextField("", text: $chatRoomLink)
                    .foregroundColor(
                        Color(hexcode: "000000")
                            .opacity(0.87)
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
    }
    
    func bottomButton() -> some View {
        Button {
            // viewModel.write
        } label: {
            RoundedRectangle(cornerRadius: 4)
                .fill(ColorConstant.main.color())
                .frame(height: 42)
                .overlay(
                    HStack(spacing: 11) {
                        Image("Write")
                            .resizable()
                            .frame(width: 18, height: 18)
                        
                        TextWithFont(text: "작성하기", font: .robotoMedium, size: 15)
                            .foregroundColor(Color(hexcode: "FFFFFF"))
                    }
                )
                .rectangleShadows([Shadow(color: .black, opacity: 0.12, radius: 5, locationX: 0, locationY: 1),
                                   Shadow(color: .black, opacity: 0.14, radius: 2, locationX: 0, locationY: 2),
                                   Shadow(color: .black, opacity: 0.2, radius: 1, locationX: 0, locationY: 3)])
        }
    }
    
}

struct WritePostView_Previews: PreviewProvider {
    static var previews: some View {

        WritePostView()

    }
}
