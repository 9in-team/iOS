//
//  ProfileEditView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/29.
//

import SwiftUI
import Combine

struct ProfileEditView: View {
    
    private let photoPicker = PhotoPicker()
    
    @StateObject private var coordinator = Coordinator()
    
    @StateObject private var viewModel = ProfileEditViewModel()
    
    @State private var cancellables = Set<AnyCancellable>()
    
    @State private var showPhotoPicker = false
    
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
        .onDisappear {
            self.cancellables = .init()
        }
    }
    
    func mainBody() -> some View {
        VStack(spacing: 30) {
            profileImage()

            email()
                .frame(width: 230)
            
            nickname()
                .frame(width: 230)
            
            Button {
                viewModel.editUserProfile()
            } label: {

            }
            .buttonStyle(SubmitButtonStyle(.halfSize(color: .primary, font: .small)))
            
            Spacer()
            
            // FIXME: 로그아웃버튼 Fix되면 해당 위치/디자인으로 바꿔야함.
            Button("로그아웃") {
                viewModel.logout()
            }
            .buttonStyle(SubmitButtonStyle(.halfSize(color: .primary, font: .small, imageName: "Logout")))
        }
    }
    
    func profileImage() -> some View {
        ZStack {
            Circle()
                .fill(Color(hexcode: "D9D9D9"))
            
            if let image = viewModel.profileImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 140, height: 140)
            } else {
                ProgressView()
                        .scaleEffect(1.5, anchor: .center)
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .clipShape(Circle())
                        .frame(width: 140, height: 140)
            }
            
            VStack {
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    Button {
                        showPhotoPicker.toggle()
                        
                        photoPicker.imagePublisher
                            .sink { completion in
                                switch completion {
                                case .failure(let error):
                                    error.printAndTypeCatch()
                                    return
                                case .finished:
                                    print("이미지 송신 완료")
                                }
                                
                        } receiveValue: { image in
                            viewModel.profileImage = image
                        }
                        .store(in: &cancellables)

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
                    .sheet(isPresented: $showPhotoPicker) {
                        self.photoPicker
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
            
            TextWithFont(text: $viewModel.email.wrappedValue, size: 16)
            
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
    
    
}

#if DEBUG
struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView()
    }
}
#endif
