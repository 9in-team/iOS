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
            
            titleLabel
            
            loginButtons
        }
    }
    
    private var titleLabel: some View {
        VStack(alignment: .center) {
            TextWithFont(text: "9in.team", font: .godoB, size: 48)
                .foregroundColor(ColorConstant.white.color())
            
            TextWithFont(text: "스터디, 프로젝트 같이 할 사람?", font: .godoB, size: 16)
                .foregroundColor(ColorConstant.white.color())
        }
    }
    
    private var loginButtons: some View {
        VStack {
            Spacer()

            KakaoSignInButton(viewModel: viewModel)

            SignInWithAppleButton(.signIn,
                                  onRequest: viewModel.appleSignInOnRequest(_:),
                                  onCompletion: viewModel.appleLogin(_:))
            .frame(height: 50)
            
            bottomSpacer()
        }
        .padding(.horizontal, 36)
    }
    
    private func bottomSpacer() -> some View {
        Rectangle()
            .fill(Color.clear)
            .frame(height: 48)
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
