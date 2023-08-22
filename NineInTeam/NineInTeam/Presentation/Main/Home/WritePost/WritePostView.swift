//
//  WritePostView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/20.
//

import SwiftUI
import Combine

struct WritePostView: View {
    
    @StateObject private var viewModel = WritePostViewModel()
        
    @State private var showAddTagAlert = false
    @State private var showSubmitAlert = false
    @State private var showRoleAlert = false
    @State private var isShowAlert = false

    @State private var selectedIndex: Int = 0
    @State private var templateIndex: Int = 1
    
}

extension WritePostView {
    
    var body: some View {
        BaseView(appState: viewModel.appState) {
            mainBody()
                .showNavigationBar(NavigationBar(useDismissButton: true, title: "모집글 작성"))
        }
        .drawOnRootViewController(isPresented: $showRoleAlert) {
            RoleAlert(viewModel: viewModel, showRoleAlert: $showRoleAlert)
        }
    }
    
    func mainBody() -> some View {
        ScrollView(showsIndicators: false) {
            
            subjectTypeSwitch(selected: $viewModel.subjectType)
            
            VStack(alignment: .leading, spacing: 30) {
                titleView()
                
                tagView()
                
                recruitmentRole()
                
                BorderedTextEditorWithTitle(title: "팀 설명", text: $viewModel.content)

                submissionForms()
                
                teamChatRoomLink()
                
                submitButton()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
        }
    }
    
    private func subjectTypeSwitch(selected: Binding<SubjectType>) -> some View {
        CheckboxButtonGroups($viewModel.subjectType)
            .scrollEnabled(false)
            .padding(.horizontal, 20)
            .padding(.bottom, 14)
    }
    
    private func titleView() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            TextWithFont(text: "제목", font: .robotoBold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
                .padding(.bottom, 4)
            
            TextField("제목을 입력하세요.", text: $viewModel.subject)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.87)
                )
            
            titleUnderLine()
        }
    }
    
    private func titleUnderLine() -> some View {
        Divider()
            .frame(height: 1)
            .foregroundColor(
                Color(hexcode: "000000")
                    .opacity(0.42)
            )
            .border(
                Color(hexcode: "000000")
                    .opacity(0.42),
                width: 1)
    }
    
    private func tagView() -> some View {
        VStack(alignment: .leading, spacing: 14) {
            TextWithFont(text: "태그",
                         font: .robotoBold, size: 12)
            .foregroundColor(
                Color(hexcode: "000000")
                    .opacity(0.6)
            )
            .padding(.horizontal, 20)
            
            tagsScrollView()
        }
        .padding(.horizontal, -20)
    }
    
    private func tagsScrollView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 17)
                
                ForEach(viewModel.hashtags.indices, id: \.self) { index in
                    let tag = viewModel.hashtags[index]
                    tagCell(tag)
                        .onTapGesture {
                            viewModel.hashtags.remove(at: index)
                        }
                }
                
                addTagButton()
                
                Rectangle()
                    .fill(.clear)
                    .frame(width: 17)
            }
        }
        .scrollEnabled(viewModel.hashtags.isEmpty ? false : true)
    }
    
    private func addTagButton() -> some View {
        ZStack {
            Circle()
                .foregroundColor(Color(hexcode: "E0E0E0"))
                .frame(width: 24, height: 24)
                .circleShadows([
                    Shadow(color: .black, opacity: 0.12, radius: 1.5, locationY: 2),
                    Shadow(color: .black, opacity: 0.14, radius: 0.5, locationY: 1),
                    Shadow(color: .black, opacity: 0.20, radius: 0.5, locationY: 1)
                               ])
            addTagButtonMenu()
        }
        .frame(height: 32)
    }
    
    private func addTagButtonMenu() -> some View {
        Menu {
            ForEach(viewModel.allTag, id: \.self) { tag in
                Button {
                    viewModel.hashtags.append(HashTag(tag))
                } label: {
                    Text(tag)
                        .font(.custom(.robotoRegular, size: 13))
                }
            }
        } label: {
            Image("Plus")
                .resizable()
                .frame(width: 14, height: 14)
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
    
    private func recruitmentRole() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            TextWithFont(text: "모집 역할", font: .robotoBold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
                .padding(.bottom, 14)
                .padding(.horizontal, 20)
            
            recruitmentRoleCellsScrollView()
        }
        .padding(.horizontal, -20)
    }
    
    private func recruitmentRoleCellsScrollView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 10, height: 120)

                ForEach(viewModel.roles, id: \.self) { role in
                    roleCell(from: role)
                }
                
                roleAddButton()
            }
        }
        .scrollEnabled(viewModel.roles.isEmpty ? false : true)
    }
    
    private func roleCell(from role: Role) -> some View {
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
    
    private func roleAddButton() -> some View {
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
    
    private func submissionForms() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            TextWithFont(text: "지원 양식", font: .robotoBold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
            
            VStack(spacing: 20) {
                ForEach(viewModel.templates, id: \.self) { form in
                    SubmissionFormView(form: form)
                }
                
                addFormMenuContainer()
            }
            .padding(.horizontal, 5)
        }
    }
    
    private func addFormMenuContainer() -> some View {
        ZStack {
            Circle()
                .frame(width: 56, height: 56)
                .foregroundColor(Color(hexcode: "E0E0E0"))
                .circleShadows([
                    Shadow(color: .black, opacity: 0.12, radius: 9, locationY: 1),
                    Shadow(color: .black, opacity: 0.14, radius: 5, locationY: 6),
                    Shadow(color: .black, opacity: 0.20, radius: 2.5, locationY: 3)
                ])
            
            submissionMenu()
        }
      
    }
    
    private func submissionMenu() -> some View {
        Menu {
            ForEach(SubmissionFormType.allCases.indices, id: \.self) { index in
                submissionMenuButton(index: index)
            }
        } label: {
            Image("Plus")
                .resizable()
                .frame(width: 16, height: 16)
        }
    }
    
    private func submissionMenuButton(index: Int) -> some View {
        let template = SubmissionFormType(rawValue: index)!
        
        return Button {
            let newTemplate = SubmissionForm(number: templateIndex,
                                             type: template,
                                             options: [])
            templateIndex += 1
            viewModel.templates.append(newTemplate)
        } label: {
            Text(template.text())
        }
    }
    
    private func teamChatRoomLink() -> some View {
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
    
    private func submitButton() -> some View {
        Button {
            viewModel.submit()
            print("작성하기 버튼 눌렀음")
        } label: {
            SubmitButton(title: "작성하기",
                         imageName: "Write",
                         style: .large(color: .primary, font: .small))
        }
    }
    
}

#if DEBUG
struct WritePostView_Previews: PreviewProvider {
    
    static var previews: some View {
        WritePostView()
    }
    
}
#endif
