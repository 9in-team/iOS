//
//  NavigationBar.swift
//  9in.team
//
//  Created by ์กฐ์ํ on 2023/02/06.
//

import SwiftUI

struct NavigationBar: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let useDismissButton: Bool
    let title: String
    var useProfileButton: Bool = true
    var useChatButton: Bool = true
    
    var body: some View {
        ZStack {
            ColorConstant.main.color()
                .ignoresSafeArea()
            
            HStack(alignment: .center) {                
                if useDismissButton {
                    Button {
                        
                    } label: {
                        Image("NavigationBack")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 11, height: 24)
                    }
                    
                    Spacer()
                        .frame(width: 10)
                }
                
                Text(title)
                    .font(.custom("GodoB", size: title == "9in.team" ? 36 : 24))
                    .foregroundColor(.white)
                                
                Spacer()
                
                HStack {
                    if useProfileButton {
                        Button {
                            
                        } label: {
                            Image("ProfileEdit")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 23, height: 20)
                        }
                        
                        Spacer()
                            .frame(width: 23)
                    }
                    
                    if useChatButton {
                        Button {
                            
                        } label: {
                            Image("Chat")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                        }
                        
                        Spacer()
                            .frame(width: 10)
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
        }
    }
    
}
