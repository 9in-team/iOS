//
//  ProfileEditView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/29.
//

import SwiftUI

struct ProfileEditView: View {
    
    @StateObject var coordinator = Coordinator()
    
    @StateObject var viewModel = ProfileEditViewModel()
    
    @State var editedNickname: String = "김진홍"
    
}

extension ProfileEditView {
    
    var body: some View {
        BaseView(appState: viewModel.appState, coordinator: coordinator) {
            mainBody()
                .showNavigationBar(NavigationBar(coordinator: coordinator,
                                                 useDismissButton: true,
                                                 title: "회원정보 수정",
                                                 useProfileButton: false))
        }
    }
    
    func mainBody() -> some View {
        VStack(spacing: 30) {
            profileImage()
            
            email()
                .frame(width: 230)
            
            nickname()
                .frame(width: 230)
            
            bottomButton()
                .frame(width: 230)
        }
    }
    
    func profileImage() -> some View {
        ZStack {
            Circle()
                .fill(Color(hexcode: "D9D9D9"))
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        // 프로필 이미지 선택
                    } label: {
                        Circle()
                            .fill(Color(hexcode: "E0E0E0"))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Image("Edit")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                            )
                    }
                    .circleShadows(firstX: 0, firstY: 1, secondX: 0, secondY: 6)
                }
            }
        }
        .frame(width: 140, height: 140)
    }
    
    func email() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            TextWithFont(text: "이메일 주소", size: 12)
            
            TextWithFont(text: "9in.team@9in.team", size: 16)
            
            Line()
               .stroke(style: StrokeStyle(lineWidth: 1, dash: [1]))
               .frame(height: 1)
        }
        .foregroundColor(
            Color(hexcode: "000000")
                .opacity(0.38)
        )
    }
    
    func nickname() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            TextWithFont(text: "닉네임", size: 12)
                .opacity(0.6)
            
            TextField("", text: $editedNickname)
                .opacity(0.87)
                
            Rectangle()
                .frame(height: 1)
                .opacity(0.42)
        }
        .foregroundColor(Color(hexcode: "000000"))
    }
    
    func bottomButton() -> some View {
        Button {
            // viewModel.edit
        } label: {
            RoundedRectangle(cornerRadius: 4)
                .fill(ColorConstant.main.color())
                .frame(height: 42)
                .overlay(
                    HStack(spacing: 11) {
                        Image("Check")
                            .resizable()
                            .frame(width: 18, height: 13)
                        
                        TextWithFont(text: "수정", font: .robotoMedium, size: 15)
                            .foregroundColor(Color(hexcode: "FFFFFF"))
                    }
                )
                .rectangleShadows(firstX: 0, firstY: 1, secondX: 0, secondY: 2)
        }
    }
    
}
