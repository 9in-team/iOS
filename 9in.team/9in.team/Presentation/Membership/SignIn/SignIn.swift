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
            NavigationLink(destination: SignUp(), isActive: $viewModel.moveSignUp) {
                EmptyView()
            }
            
            ColorConstant.main.color()
                .edgesIgnoringSafeArea(.all)                                                          
                        
            VStack {
                Text("9in.team")
                    .font(.custom("GodoB", size: 48))
                    .foregroundColor(.white)
                
                Text("스터디, 프로젝트 같이 할 사람?")
                    .font(.custom("GodoB", size: 16))
                    .foregroundColor(.white)
            }            
         
            VStack {
                Spacer()
             
                Button(action: {
                    viewModel.requestKakaoLogin()
                }, label: {
                    HStack {
                        Image("KakaoSymbol")
                     
                        Spacer()
                        
                        Text("카카오로그인")
                            .foregroundColor(Color.init(red: 0, green: 0, blue: 0, opacity: 0.85))
                        
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                    .frame(height: 50)
                    .background(Color.init(hexcode: "FEE500"))
                    .cornerRadius(5)
                })
                .padding(.horizontal, 20)
                .padding()
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
