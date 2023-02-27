//
//  SignUp.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/12.
//

import SwiftUI
import PhotosUI

struct SignUp: View {
    
    @StateObject var viewModel = SignViewModel()
        
    @State private var onPhotoLibrary = false
    
    @State var image: UIImage?
    @State var email: String = "9in.team@9in.team"
    @State var nickname: String = "9in.team"
    
    @State var isOn1: Bool = false
    @State var isOn2: Bool = false
    
}

extension SignUp {
    
    var body: some View {
        BaseView {
            ZStack(alignment: .bottomTrailing) {
                CircleImage(image: image)
                    .frame(width: 140, height: 140)
                                
                ZStack {
                    Circle()
                        .foregroundColor(Color.init(hexcode: "E0E0E0"))
                        .frame(width: 40, height: 40)
                    
                    Image("Edit")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 18, height: 18)
                }
            }
            .onTapGesture {
                onPhotoLibrary = true
            }
            .padding(.bottom, 30)
           
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("이메일 주소")
                        .font(.system(size: 12))
                        .foregroundColor(Color.init(red: 0, green: 0, blue: 0, opacity: 0.38))
                        .padding(.bottom, 5.5)
                    
                    TextField("", text: $email)
                        .foregroundColor(Color.init(red: 0, green: 0, blue: 0, opacity: 0.38))
                        .padding(.bottom, 6.5)
                    
                    Line()
                      .stroke(style: StrokeStyle(lineWidth: 1, dash: [1]))
                      .frame(height: 1)
                      .foregroundColor(Color.init(red: 0, green: 0, blue: 0, opacity: 0.42))
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("닉네임")
                        .font(.system(size: 12))
                        .padding(.bottom, 5.5)
                    
                    TextField("", text: $nickname)
                        .padding(.bottom, 6.5)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.init(red: 0, green: 0, blue: 0, opacity: 0.42))
                }
            }
            .frame(width: 250)
            .padding(.bottom, 55)
            
            VStack(spacing: 20) {
                HStack {
                    Toggle("", isOn: $isOn1)
                        .frame(width: 18, height: 18)
                        .toggleStyle(CheckBoxStyle(style: .square))
                        .foregroundColor(Color.init(red: 0, green: 0, blue: 0, opacity: 0.6))
                    
                    Text("서비스 이용약관 동의")
                        .font(.system(size: 16))
                    
                    Text("(필수)")
                        .font(.system(size: 16))
                        .foregroundColor(Color.gray)
                    
                    Spacer()
                }
                
                HStack {
                    Toggle("", isOn: $isOn2)
                        .frame(width: 18, height: 18)
                        .toggleStyle(CheckBoxStyle(style: .square))
                        .foregroundColor(Color.init(red: 0, green: 0, blue: 0, opacity: 0.6))
                                        
                    Text("개인정보 처리방침 동의")
                        .font(.system(size: 16))
                    
                    Text("(필수)")
                        .font(.system(size: 16))
                        .foregroundColor(Color.gray)
                    
                    Spacer()
                }
            }
            .frame(width: 250)
            .padding(.bottom, 30)
            
            Button {
                if let image = image {
                    viewModel.uploadImage(image) { imageUrl in
                        viewModel.join(email: email, nickname: nickname, imageUrl: imageUrl.absoluteString)
                    }
                } else {
                    viewModel.join(email: email, nickname: nickname)
                }
            } label: {
                ZStack {
                    Rectangle()
                             .fill(Color.blue)
                             .frame(width: 250, height: 42)
                    
                    HStack {
                        EmbedCircleImage(imageUrl: "Check")
                            .frame(width: 20, height: 20)
                        
                        Text("가입하기")
                            .font(.system(size: 15))
                            .foregroundColor(Color.white)
                    }
                }
                .cornerRadius(5)
            }
        }
        .showNavigationBar(NavigationBar(useDismissButton: true,
                                         title: "회원가입",
                                         useProfileButton: false,
                                         useChatButton: false))
        .sheet(isPresented: $onPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary) { pickedImage in
                image = pickedImage
            }
            
        }
    }
    
}
