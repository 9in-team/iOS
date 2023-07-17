//
//  SignInView.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/12.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
         
    @StateObject private var viewModel = SignViewModel()
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        BaseView(appState: viewModel.appState) {
            mainBody
        }
    }
    
}

extension SignInView {
    
    var mainBody: some View {
        ZStack {
            ColorConstant.main.color()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                TextWithFont(text: "9in.team", font: .godoB, size: 48)
                    .foregroundColor(ColorConstant.white.color())
                
                TextWithFont(text: "스터디, 프로젝트 같이 할 사람?", font: .godoB, size: 16)
                    .foregroundColor(ColorConstant.white.color())
                
                Spacer()
            }            
         
            VStack {
                Spacer()

                kakaoSignInButton()
                
                appleSignInButton()
                
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 48)
            }
            .padding(.horizontal, 36)

        }
    }
    
    private func appleSignInButton() -> some View {
        SignInWithAppleButton(.signIn,
                              onRequest: viewModel.appleSignInOnRequest(_:),
                              onCompletion: viewModel.appleSignInRequestToServer)
        .frame(height: 50)
    }
    
    private func kakaoSignInButton() -> some View {
        Button(action: {
            viewModel.kakaoLogin()
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
            .ignoresSafeArea()
    }
}
#endif
