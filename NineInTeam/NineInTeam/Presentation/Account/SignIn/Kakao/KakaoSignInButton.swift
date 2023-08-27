//
//  KakaoSignInButton.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 8/27/23.
//

import SwiftUI

struct KakaoSignInButton: View {
    
    @ObservedObject var viewModel: SignViewModel
    
}

extension KakaoSignInButton {
    
    var body: some View {
        Button(action: {
            viewModel.kakaoLogin()
        }, label: {
            label
        })
        .frame(height: 50)
        .background(ColorConstant.kakaoContainer.color())
        .cornerRadius(12)
    }
    
    var label: some View {
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
    }
}

#if DEBUG
struct KakaoSignInButton_Previews: PreviewProvider {
    static var previews: some View {
        KakaoSignInButton(viewModel: SignViewModel())
    }
}
#endif
