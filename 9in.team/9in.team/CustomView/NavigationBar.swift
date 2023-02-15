//
//  NavigationBar.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/06.
//

import SwiftUI

struct NavigationBar: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let showDismissButton: Bool
    let title: String
    let useProfileButton: Bool = true
    let useChatButton: Bool = true
    
    var body: some View {
        ZStack {
            ColorConstant._default.color()
                .ignoresSafeArea()
                .navigationTitle("")
                .navigationBarHidden(true)
//                .toolbar(.hidden)
            
            HStack {
                if showDismissButton {
                    Image("")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                
                Text(title)
                    .font(.custom("GodoB", size: 36))
                    .foregroundColor(.white)
                
                
                Spacer()
                
                HStack {
                    if useProfileButton {
                        Image("")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    
                    if useChatButton {
                        Image("")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
            }
            .padding()
        }
    }
    
}
