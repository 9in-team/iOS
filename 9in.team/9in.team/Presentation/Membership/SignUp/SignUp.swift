//
//  SignUp.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/12.
//

import SwiftUI

struct SignUp: View {
    
    @State var imageUrl: String = ""
    @State var email: String = "deepred-k@naver.com"
    @State var nickname: String = "김진홍"
    
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
            
            Rectangle()
                .frame(width: 1, height: 20)
                .foregroundColor(Color.clear)
                        
            VStack(alignment: .leading) {
                Text("이메일 주소")
                    .font(.system(size: 12))
                    .foregroundColor(Color.gray)
                
                TextField("", text: $email)
                    .foregroundColor(Color.gray)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.white)
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
            }
            .frame(width: 230)
            
            VStack(alignment: .leading) {
                Text("닉네임")
                    .font(.system(size: 12))
                
                TextField("", text: $nickname)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.white)
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
            }
            .frame(width: 230)
            
            Rectangle()
                .frame(width: 1, height: 30)
                .foregroundColor(Color.clear)
            
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
            .frame(width: 230)

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
            .frame(width: 230)
            
            Rectangle()
                .frame(width: 1, height: 20)
                .foregroundColor(Color.clear)
            
            Button {
                   // 실행할 코드
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
    }
    
}
