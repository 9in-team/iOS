//
//  SignInView.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/12.
//

import SwiftUI

struct SignInView: View {
         
    @StateObject var viewModel = SignViewModel()
    
}

extension SignInView {
    
    var body: some View {
        ZStack {
            ColorConstant.main.color()
                .edgesIgnoringSafeArea(.all)
            VStack {
                TextWithFont(text: "9in.team", font: .godoB, size: 48)
                    .foregroundColor(ColorConstant.white.color())
                
                TextWithFont(text: "스터디, 프로젝트 같이 할 사람?", font: .godoB, size: 16)
                    .foregroundColor(ColorConstant.white.color())
            }            
         
            VStack {
                Spacer()
                kakaoLoginView()
                    .padding(.horizontal, 20)
                    .padding()
            }
        }
        .onOpenURL(perform: { url in
            viewModel.canOpen(url)
        })
    }
    
    private func kakaoLoginView() -> some View {
        Button(action: {
            viewModel.requestKakaoLogin()
        }, label: {
            ZStack {
                HStack {
                    Image("KakaoSymbol")
                        .resizable()
                        .scaledToFit()
                 
                    Spacer()
                    
                    Text("카카오 로그인")
                        .font(.system(size: 16))
                        .foregroundColor(ColorConstant.black.color().opacity(0.85))
                    
                    Spacer()
                }
                .frame(height: 16)
            }
            .padding(.horizontal, 15)
            .frame(height: 50)
            .background(ColorConstant.kakaoContainer.color())
            .cornerRadius(12)
        })
    }
    
}

#if DEBUG
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
#endif
