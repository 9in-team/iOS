//
//  ProfileEditView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/29.
//

import SwiftUI

struct ProfileEditView: View {
    
    @StateObject private var coordinator = Coordinator()
    @StateObject private var viewModel = ProfileEditViewModel()
    
    @EnvironmentObject private var userAuthManager: UserAuthManager
    
    @State private var editedNickname: String = "김진홍"
    
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
            
            actionButton(title: "수정", imageName: "Check") {
                
            }
            .frame(width: 230)
            
            Spacer()
            
            actionButton(title: "로그아웃", imageName: "Logout") { // FIXME: 로그아웃버튼 Fix되면 해당 위치/디자인으로 바꿔야함.
                userAuthManager.logout()
            }
            .frame(width: 230)
        }
        .onAppear {
            viewModel.getProfileData()
        }
    }
    
    func profileImage() -> some View {
        ZStack {
            Circle()
                .fill(Color(hexcode: "D9D9D9"))
            Image(uiImage: viewModel.profileImage ?? UIImage())
                .clipShape(Circle())
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
                    .circleShadows([Shadow(color: .black, opacity: 0.12, radius: 18, locationY: 1),
                                    Shadow(color: .black, opacity: 0.14, radius: 10, locationY: 6),
                                    Shadow(color: .black, opacity: 0.2, radius: 5, locationY: 3)])
                }
            }
        }
        .frame(width: 140, height: 140)
    }
    
    func email() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            
            TextWithFont(text: "이메일 주소", size: 12)
            
            TextWithFont(text: $viewModel.email.wrappedValue ?? "9in.team@9in.team", size: 16)
            
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
                        
            TextField("", text: $viewModel.nickname)
                .opacity(0.87)
                
            Rectangle()
                .frame(height: 1)
                .opacity(0.42)
        }
        .foregroundColor(Color(hexcode: "000000"))
    }
    
    func actionButton(title: String,
                      imageName: String,
                      action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 4)
                .fill(ColorConstant.main.color())
                .frame(height: 42)
                .overlay(
                    HStack(spacing: 11) {
                        Image(imageName)
                            .resizable()
                            .frame(width: 18, height: 13)
                        
                        TextWithFont(text: title, font: .robotoMedium, size: 15)
                            .foregroundColor(Color(hexcode: "FFFFFF"))
                    }
                )
                .rectangleShadows([Shadow(color: .black, opacity: 0.12, radius: 5, locationX: 0, locationY: 1),
                                   Shadow(color: .black, opacity: 0.14, radius: 2, locationX: 0, locationY: 2),
                                   Shadow(color: .black, opacity: 0.2, radius: 3, locationX: 0, locationY: 1)])
        }
    }
    
}
