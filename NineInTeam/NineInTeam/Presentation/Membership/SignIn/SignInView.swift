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
                TextWithFont(text: "9in.team", font: nil, size: 48)
                    .foregroundColor(Color(hexcode: "FFFFFF"))
                
                TextWithFont(text: "스터디, 프로젝트 같이 할 사람?", font: nil, size: 16)
                    .foregroundColor(Color(hexcode: "FFFFFF"))
            }            
         
            VStack {
                Spacer()
             
                Button(action: {
                    viewModel.requestKakaoLogin()
                }, label: {
                    HStack {
                        Image("KakaoSymbol")
                     
                        Spacer()
                        
                        TextWithFont(text: "카카오로그인", font: .medium, size: 16)
                            .foregroundColor(Color(hexcode: "FFFFFF").opacity(0.85))
                        
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                    .frame(height: 50)
                    .background(Color(hexcode: "FEE500"))
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
