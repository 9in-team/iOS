//
//  WritePostView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/20.
//

import SwiftUI

struct WritePostView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    @State var isShowAlert: Bool = false
    @State var anyAlert: AnyView = AnyView(EmptyView())
    
    let category: [String] = ["스터디", "프로젝트"]
    @State var selectedIndex: Int = 0
    
    @State var subject: String = ""
    
    @State var showAddTagAlert: Bool = false
    @State var tags: [String] = ["알고리즘"]
    
    @State var showAddRecruitmentRoleAlert: Bool = false
    @State var recruitmentRoles: [RecruitmentRole] = [RecruitmentRole(title: "프론트엔트 개발자", count: 4),
                                                      RecruitmentRole(title: "디자이너", count: 4)]
    
    @State var showAddSubmissionFormAlert: Bool = false
    @State var submissionForms: [SubmissionForm] = [SubmissionForm(no: 1, type: .text, content: "solved.ac 티어가 어떻게 되세요?"),
                                                    SubmissionForm(no: 2, type: .image, content: "solved.ac 프로필 사진 찍어주세요"),
                                                    SubmissionForm(no: 3, type: .file, content: "포트폴리오 첨부해주세요"),
                                                    SubmissionForm(no: 4, type: .choice, content: "열심히 하실거죠?")]
    
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
                radioGroup()
                
                title()
                
                tag()
                
                recruitmentRole()
                
                teamExplanation()
                
                submissionForm()

                teamChatRoomLink()
                
                bottomButton()
            }
            .padding(.horizontal, 5)
            .padding(.bottom, 10)
        }
    }
    
    func radioGroup() -> some View {
        RadioButtonGroups(items: category) { index in
            selectedIndex = index
        }
    }
    
    func title() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            TextWithFont(text: "제목", font: .bold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
            
            VStack(alignment: .leading, spacing: 5) {
                TextField("", text: $subject)
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
    
    func tag() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            TextWithFont(text: "태그", font: .bold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(tags, id: \.self) { tag in
                        TextWithFont(text: tag, font: .regular, size: 13)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 10)
                            .background(
                                Capsule(style: .continuous)
                                    .stroke(Color(hexcode: "000000").opacity(0.26))
                            )
                            .frame(height: 35)
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
            TextWithFont(text: "모집 역할", font: .bold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(recruitmentRoles, id: \.self) { role in
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
                         
                    Button {
                        showAddRecruitmentRoleAlert = true
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
                    .drawOnRootViewController(isPresented: $showAddRecruitmentRoleAlert) {
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
                TextWithFont(text: "팀 설명", font: .bold, size: 12)
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
                TextWithFont(text: "asdf\nasdfa]nasdfa\nadf\nasdfasd\nasdf", font: .regular, size: 16)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 12)
        }
        .frame(height: 230)
        .frame(maxWidth: .infinity)
    }
    
    func submissionForm() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            TextWithFont(text: "지원 양식", font: .bold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
            
            VStack(spacing: 20) {
                ForEach(submissionForms, id: \.self) { form in
                    HStack(spacing: 8) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color(hexcode: "000000")
                                    .opacity(0.23)
                                )
                                .frame(width: 62, height: 62)
                                .overlay(
                                    TextWithFont(text: "\(form.no)", font: .medium, size: 12)
                                        .foregroundColor(Color(hexcode: "FFFFFF"))
                                        .padding(6)
                                        .background(
                                            Circle()
                                                .fill(Color(hexcode: "1976D2"))
                                        )
                                        .offset(x: -31, y: -31)
                                )
                            
                            VStack(spacing: 5) {
                                Image(form.type.asset())
                                    .resizable()
                                    .frame(width: form.type.assetSize().width, height: form.type.assetSize().height)
                                    .padding(.top, 3)
                                
                                TextWithFont(text: form.type.text(), font: .regular, size: 12)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            TextWithFont(text: form.content, font: .regular, size: 16)
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
                
                Button {
                    showAddSubmissionFormAlert = true
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
                .drawOnRootViewController(isPresented: $showAddSubmissionFormAlert) {
                    BaseAlert {
                        Text("showAddSubmissionFormAlert = false")
                    }
                }
            }
            .padding(.horizontal, 5)
        }
    }
    
    func teamChatRoomLink() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            TextWithFont(text: "팀 채팅방 링크", font: .bold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
            
            TextWithFont(text: "Slack, 오픈채팅방 등 팀에서 사용할 채팅방 링크를 적어주세요.\n승인 처리한 지원자에게 자동 전달됩니다.",
                         font: .regular, size: 12)
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
                        
                        TextWithFont(text: "작성하기", font: .medium, size: 15)
                            .foregroundColor(Color(hexcode: "FFFFFF"))
                    }
                )
            .rectangleShadows(firstX: 0, firstY: 1, secondX: 0, secondY: 2)
        }
    }
    
}
