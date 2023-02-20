//
//  SignUp.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/12.
//

import SwiftUI

struct SignUp: View {
    
    @StateObject var viewModel = SignViewModel()
    
    @State var imageUrl: String = ""
    @State var email: String = "9in.team@9in.team"
    @State var nickname: String = "9in.team"
    
}

extension SignUp {
    
    var body: some View {
        BaseView {
            ZStack(alignment: .bottomTrailing) {
                CircleImage(imageUrl: imageUrl)
                    .frame(width: 140, height: 140)
                
                CircleImage(imageUrl: "EditImage")
                    .frame(width: 40, height: 40)
            }
            
            Spacer()
                .frame(height: 15)
           
            VStack {
                VStack(alignment: .leading) {
                    Text("이메일 주소")
                        .font(.system(size: 12))
                        .foregroundColor(Color.gray)
                    
                    TextField("", text: $email)
                        .foregroundColor(Color.gray)
                }
                
                Spacer()
                    .frame(width: 1, height: 10)
                
                VStack(alignment: .leading) {
                    Text("닉네임")
                        .font(.system(size: 12))
                    
                    TextField("", text: $nickname)
                }
            }
            .frame(width: 230)
            
            Spacer()
                .frame(height: 30)
            
            VStack {
                HStack {
                    Image("CheckBoxUnChecked")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 18, height: 18)
                    
                    Text("서비스 이용약관 동의")
                        .font(.system(size: 16))
                    
                    Text("(필수)")
                        .font(.system(size: 16))
                        .foregroundColor(Color.gray)
                    
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 10)
                
                HStack {
                    Image("CheckBoxUnChecked")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 18, height: 18)
                    
                    Text("개인정보 처리방침 동의")
                        .font(.system(size: 16))
                    
                    Text("(필수)")
                        .font(.system(size: 16))
                        .foregroundColor(Color.gray)
                    
                    Spacer()
                }
            }
            .frame(width: 230)
            
            Spacer()
                .frame(height: 15)
            
            Button {                
                viewModel.join(email: email, nickname: nickname)
            } label: {
                ZStack {
                    Rectangle()
                             .fill(Color.blue)
                             .frame(width: 230, height: 42)
                    
                    HStack {
                        CircleImage(imageUrl: "Check")
                            .frame(width: 20, height: 20)
                        
                        Text("가입하기")
                            .font(.system(size: 15))
                            .foregroundColor(Color.white)
                    }
                }
            }
        }
        .showNavigationBar(NavigationBar(useDismissButton: true,
                                         title: "회원가입",
                                         useProfileButton: false,
                                         useChatButton: false))
    }
    
}
