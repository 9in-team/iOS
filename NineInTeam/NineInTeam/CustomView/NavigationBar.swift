//
//  NavigationBar.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/06.
//

import SwiftUI

struct NavigationBar: View {
    
    @State var coordinator: Coordinator = Coordinator()
    
    @Environment(\.presentationMode) var presentationMode
    
    let useDismissButton: Bool
    let title: String
    var useProfileButton: Bool = true
    var useChatButton: Bool = true    
    
    var body: some View {
        ZStack {
            ColorConstant.primary.color()
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
                                
                TextWithFont(text: title,
                             font: title == "9in.team" ? .godoB : .robotoBold,
                             size: title == "9in.team" ? 36 : 24)
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(Color(hexcode: "FFFFFF"))
                                
                Spacer()
                
                HStack(spacing: 25) {
                    if useProfileButton {
                        Button {
                            coordinator.push(destination: .profileEdit)
                        } label: {
                            Image("ProfileEdit")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 23, height: 20)
                        }
                    }
                    
                    if useChatButton {
                        Button {
                            coordinator.push(destination: .chatList)
                        } label: {
                            Image("Chat")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 23, height: 20)
                        }
                    }
                }
                .padding(.trailing, 10)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
        }
    }
    
}
