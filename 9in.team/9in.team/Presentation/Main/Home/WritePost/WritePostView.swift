//
//  WritePostView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/20.
//

import SwiftUI

struct WritePostView: View {
    
    let category: [String] = ["스터디", "프로젝트"]
    @State var selectedIndex: Int = 0
    
    @State var subject: String = ""
    
}

extension WritePostView {
    
    var body: some View {
        BaseView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    RadioButtonGroups(items: category) { index in
                        selectedIndex = index
                    }
                    
                    VStack(alignment: .leading) {
                        TextWithFont(text: "제목", font: .bold, size: 12)
                            .foregroundColor(
                                Color(hexcode: "000000")
                                    .opacity(0.6)
                            )
                        
                        VStack(alignment: .leading, spacing: 5) {
                            TextField("", text: $subject)
                                .foregroundColor(
                                    Color(hexcode: "000000")
                                        .opacity(0.87)
                                )
                                      
                            Divider()
                                .frame(height: 1)
                                .foregroundColor(
                                    Color(hexcode: "000000")
                                        .opacity(0.42)
                                )
                                .border(Color.init(hexcode: "000000").opacity(0.42),
                                        width: 1)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        TextWithFont(text: "태그", font: .bold, size: 12)
                            .foregroundColor(
                                Color(hexcode: "000000")
                                    .opacity(0.6)
                            )
                    }
                    
                    VStack(alignment: .leading) {
                        TextWithFont(text: "모집역할", font: .bold, size: 12)
                            .foregroundColor(
                                Color(hexcode: "000000")
                                    .opacity(0.6)
                            )
                    }
                    
                    VStack(alignment: .leading) {
                        TextWithFont(text: "지원양식", font: .bold, size: 12)
                            .foregroundColor(
                                Color(hexcode: "000000")
                                    .opacity(0.6)
                            )
                    }
                    
                    VStack(alignment: .leading) {
                        TextWithFont(text: "팀 채팅방 링크", font: .bold, size: 12)
                            .foregroundColor(
                                Color(hexcode: "000000")
                                    .opacity(0.6)
                            )
                    }
                }
                .padding(.horizontal, 20)
            }            
        }
        .showNavigationBar(NavigationBar(useDismissButton: true, title: "모집글 작성"))
    }
    
}
