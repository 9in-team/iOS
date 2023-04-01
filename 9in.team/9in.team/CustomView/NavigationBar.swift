//
//  NavigationBar.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/06.
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
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("NavigationBack")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 11, height: 24)
                    }
                    
                    Spacer()
                        .frame(width: 10)
                }
                                
                TextWithFont(text: title, font: nil, size: title == "9in.team" ? 36 : 24)
                    .frame(width: 160)
                    .foregroundColor(Color.white)
//                    .foregroundColor(Color(hexcode: "#FFFFFF")) 버그인가 색이 안들어간다
                                
                Spacer()
                
                HStack(spacing: 0) {
                    if useProfileButton {
                        NavigationLink(destination: ProfileEditView()) {
                            Image("ProfileEdit")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 23, height: 20)
                        }
                        
//                        Button {
//
//                        } label: {
//                            Image("ProfileEdit")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 23, height: 20)
//                        }
                        
                        Rectangle()
                            .frame(width: 25)
                            .foregroundColor(Color.clear)
                    }
                    
                    if useChatButton {
                        Button {
                            
                        } label: {
                            Image("Chat")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                        }
                        
                        Rectangle()
                            .frame(width: 10)
                            .foregroundColor(Color.clear)
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
        }
    }
    
}
