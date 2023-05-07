//
//  MainView.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/06.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    @State private var selection = 0
    
    func getColor(isSelected: Bool) -> Color {
        if isSelected {
            return ColorConstant.main.color()
        } else {
            return Color(red: 0, green: 0, blue: 0, opacity: 0.6)
        }
    }
    
}

extension MainView {
    
    var body: some View {
        NavigationView {
            VStack {
                if selection == 0 {
                    HomeView()                        
                } else if selection == 1 {
                    NavigationView { // 구독하기 화면 Tab Bar 노출을 위한 Navigation 계층 추가.
                        MySubscribeView()
                    }
                } else if selection == 2 {
                    MyPostView()
                } else if selection == 3 {
                    MyResumeView()
                }
                
                HStack {
                    BottomNavigationItem(imageName: "Home", imageWidth: 20, imageHeight: 17, titleName: "홈")
                        .foregroundColor(getColor(isSelected: selection == 0))
                        .onTapGesture {
                            selection = 0
                        }
                    
                    BottomNavigationItem(imageName: "Subscribe", imageWidth: 18, imageHeight: 18, titleName: "구독")
                        .foregroundColor(getColor(isSelected: selection == 1))
                        .onTapGesture {
                            selection = 1
                        }

                    BottomNavigationItem(imageName: "MyPost", imageWidth: 22, imageHeight: 14, titleName: "내 모집글")
                        .foregroundColor(getColor(isSelected: selection == 2))
                        .onTapGesture {
                            selection = 2
                        }

                    BottomNavigationItem(imageName: "MyResume", imageWidth: 18, imageHeight: 18, titleName: "내 지원서")
                        .foregroundColor(getColor(isSelected: selection == 3))
                        .onTapGesture {
                            selection = 3
                        }
                }
                .background(Color(hexcode: "FFFFFF"))
                .frame(height: 60)
            }
        }
    }
    
}
