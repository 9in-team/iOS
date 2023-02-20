//
//  MainView.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/12.
//

import SwiftUI

struct SignIn: View {
     
    @StateObject var viewModel = SignViewModel()
    
}

extension SignIn {
    
    var body: some View {
        ZStack {
            NavigationLink(destination: SignUp(), isActive: $viewModel.needSignUp) {
                EmptyView()
            }
            
            ColorConstant.main.color()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("9in.team")
                    .font(.custom("GodoB", size: 48))
                    .foregroundColor(.white)
                
                Text("스터디, 프로젝트 같이 할 사람!")
                    .font(.custom("GodoB", size: 16))
                    .foregroundColor(.white)
            }
         
            VStack {
                Spacer()
             
                Image("kakao_login_large_narrow_k")
                    .onTapGesture {
                        viewModel.requestKakaoLogin()
                    }
            }
        }
        .showNavigationBar(NavigationBar(useDismissButton: true,
                                         title: "",
                                         useProfileButton: false,
                                         useChatButton: false))
        .onOpenURL(perform: { url in
            viewModel.canOpen(url)
        })
    }
    
}
