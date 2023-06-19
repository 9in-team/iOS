//
//  ProfileEditView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/29.
//

import SwiftUI
import Combine

// TODO: ProfileEditView
// [] Photo Picker View + Firebase ImageUpload 기능 추후 구현 필요.
// [] 서버에서 받은 데이터로 이미지 가져오기
struct ProfileEditView: View {
    
    @StateObject private var coordinator = Coordinator()
    @StateObject private var viewModel = ProfileEditViewModel()
    @State private var showPhotoPicker = false
    private let photoPicker = PhotoPicker()
    @State var cancellables = Set<AnyCancellable>()
    @State private var image: UIImage = UIImage() {
        didSet {
            print("이미지 셋업됨")
        }
    }
    
    @EnvironmentObject private var userAuthManager: UserAuthManager
    
    @State private var editedNickname: String = ""
    
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
        .onAppear {
            viewModel.getProfileData()
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
            
            actionButton(title: "수정", imageName: "Check") {
                // TODO:
                // [v] 이름 업데이트
                // [v] Firebase에 이미지 올리기 -> Server에 이미지 URL 업데이트하기. -> 이미지 다시불러오기.
                viewModel.uploadImage { imageUrl in
                    print("DEBUG: STORED IMAGE URL: \(imageUrl.absoluteString)")
                    let nickName = self.editedNickname
                    viewModel.willStartLoading()
                    userAuthManager.updateData(nickname: nickName, imageUrl: imageUrl)
                    viewModel.didFinishLoading()
                }
                
            }
            .frame(width: 230)
            
            Spacer()
            
            // FIXME: 로그아웃버튼 Fix되면 해당 위치/디자인으로 바꿔야함.
            actionButton(title: "로그아웃", imageName: "Logout") {
                userAuthManager.logout()
            }
            .frame(width: 230)
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
                                    print("DEBUG IMAGE RECEIVEERROR: \(error.localizedDescription)")
                                    return
                                case .finished:
                                    print("이미지 송신 완료")
                                    break
                                }
                        } receiveValue: { image in
                            viewModel.profileImage = image
                            self.cancellables = .init()
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
            
            TextField("", text: $editedNickname)
                .opacity(0.87)
                .onAppear {
                    editedNickname = viewModel.nickname
                }
            
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

#if DEBUG
struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView()
    }
}
#endif
