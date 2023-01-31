//
//  SignUp.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/12.
//

import SwiftUI

struct SignUp: View {
    
    @StateObject var viewModel = SignViewModel()
    
}

extension SignUp {
    
    var body: some View {
        BaseView {
            VStack {
                Spacer()
             
                Image("kakao_login_large_narrow_k")                    
                    .onTapGesture {
                        viewModel.requestKakaoLogin()
                    }
            }
        }
        .onOpenURL(perform: { url in
            viewModel.canOpen(url)
        })
    }
    
}
