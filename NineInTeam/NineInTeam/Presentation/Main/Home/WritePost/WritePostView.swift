//
//  WritePostView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/20.
//

import SwiftUI
import Combine

struct WritePostView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    @State private var isShowAlert: Bool = false
    @State private var anyAlert: AnyView = AnyView(EmptyView())
    @State private var selectedIndex: Int = 0
    @State private var showAddTagAlert: Bool = false
    @State private var showSubmitAlert: Bool = false
    @State private var showRoleAlert = false
    
    @State var templateIndex: Int = 1
    
    private let allTags = ["Python", "Spring Framework", "AWS", "iOS", "HTML", "Java", "JavaScript", "C#", "C++", "JPA", "React", "Node", "Vue", "MySQL", "Kotlin", "Android", "SQL"]
    
}

extension WritePostView {
    
    var body: some View {
        BaseView(appState: viewModel.appState) {
            mainBody()
                .showNavigationBar(NavigationBar(useDismissButton: true, title: "모집글 작성"))
        }
        .drawOnRootViewController(isPresented: $showRoleAlert) {
            roleAlert()
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
            TextWithFont(text: "태그",
                         font: .robotoBold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(viewModel.hashtags.indices, id: \.self) { index in
                        let tag = viewModel.hashtags[index]
                        tagCell(tag)
                            .onTapGesture {
                                let target = viewModel.hashtags.filter { $0.name == tag.name }
                                viewModel.hashtags.remove(at: index)
                            }
                    }
                    
                    Menu {
                        ForEach(allTags, id: \.self) { tag in
                            Button {
                                viewModel.hashtags.append(HashTag(tag))
                            } label: {
                                Text(tag)
                            }
                        }
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
                         
                    Button {
                        showRoleAlert = true
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
            TextEditor(text: $viewModel.content)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textCase(.none)
                .padding(.vertical, 16)
                .padding(.horizontal, 12)
        }
        .frame(minHeight: 64, maxHeight: 230)
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
                    TeamTemplateForm(form: form)
                }
                
                Menu {
                    ForEach(TeamTemplateType.allCases.indices) { index in
                        let template = TeamTemplateType(rawValue: index)!
                        Button {
                            let newTemplate = TeamTemplate(number: templateIndex, type: template, question: "", options: [])
                            templateIndex += 1
                            viewModel.templates.append(newTemplate)
                        } label: {
                            Text(template.text() ?? "")
                        }
                    }
                } label: {
                    plusCircleButton {}
                }

            }
            .padding(.horizontal, 5)
        }
    }
    
    private func plusCircleButton(action: @escaping() -> Void) -> some View {
        Button {
            action()
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
                TextField("채팅방 링크를 기재해 주세요", text: $viewModel.openChatUrl)
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
        BaseButton(title: "작성하기", imageName: "Write") {
            // viewModel.write(accountId: <#T##Int#>, content: "")
            print("작성하기 버튼 눌렀음")
        }
    }
    
    private func roleAlert() -> some View {
        BaseAlert {
            VStack {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.init(uiColor: .secondarySystemFill))
                    
                    TextField("모집대상을 입력하세요", text: $viewModel.roleTitle)
                        .padding(.horizontal)
                        .cornerRadius(12)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .textCase(.none)
                    
                }
                .frame(height: 42)
                .padding(.top)

                Stepper("\($viewModel.roleCount.wrappedValue)") {
                    viewModel.roleCount += 1
                } onDecrement: {
                    viewModel.roleCount -= 1
                }
                    
                Spacer()
                
                BaseButton(title: "확인", imageName: nil) {
                    if viewModel.roleTitle.isEmpty {
                        viewModel.showToast(title: "모집대상을 입력해주세요.")
                        return
                    }
                    let role = Role(title: viewModel.roleTitle, count: viewModel.roleCount)
                    viewModel.roles.append(role)
                    showRoleAlert = false
                }
                
                BaseButton(title: "취소", imageName: nil) {
                    showRoleAlert = false
                }
            }
            .padding()
        }
        .onDisappear {
            viewModel.roleCount = 1
            viewModel.roleTitle = ""
            print("disappear")
        }
    }
    
}

struct WritePostView_Previews: PreviewProvider {
    static var previews: some View {

        WritePostView()

    }
}
