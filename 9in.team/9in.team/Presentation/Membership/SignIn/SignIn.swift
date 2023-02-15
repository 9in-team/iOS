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
        BaseView {
            ZStack {
                VStack {
                    Text("9in.team")
                        .font(.system(size: 36))
                    
                    Text("스터디, 프로젝트 같이 할 사람!")
                        .font(.system(size: 16))
                }                
             
                VStack {
                    Spacer()
                 
                    Image("kakao_login_large_narrow_k")
                        .onTapGesture {
                            viewModel.requestKakaoLogin()
                        }
                }
            }
        }
        .onOpenURL(perform: { url in
            viewModel.canOpen(url)
        })
    }
    
}
