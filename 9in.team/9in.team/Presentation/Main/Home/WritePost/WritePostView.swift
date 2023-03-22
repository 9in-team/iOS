//
//  WritePostView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/20.
//

import SwiftUI

struct WritePostView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    let category: [String] = ["스터디", "프로젝트"]
    @State var selectedIndex: Int = 0
    
    @State var subject: String = ""
    
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
                
                submissionForm()

                teamChatRoomLink()
            }
            .padding(.horizontal, 20)
        }
    }
    
    func radioGroup() -> some View {
        RadioButtonGroups(items: category) { index in
            selectedIndex = index
        }
    }
    
    func title() -> some View {
        VStack(alignment: .leading) {
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
                    .border(Color.init(hexcode: "000000").opacity(0.42),
                            width: 1)
            }
        }
    }
    
    func tag() -> some View {
        VStack(alignment: .leading) {
            TextWithFont(text: "태그", font: .bold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
        }
    }
    
    func recruitmentRole() -> some View {
        VStack(alignment: .leading) {
            TextWithFont(text: "모집 역할", font: .bold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
        }
    }
    
    func teamExplanation() -> some View {
        VStack(alignment: .leading) {
            TextWithFont(text: "팀 설명", font: .bold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
        }
    }
    
    func submissionForm() -> some View {
        VStack(alignment: .leading) {
            TextWithFont(text: "지원 양식", font: .bold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
        }
    }
    
    func teamChatRoomLink() -> some View {
        VStack(alignment: .leading) {
            TextWithFont(text: "팀 채팅방 링크", font: .bold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
        }
    }
    
}
