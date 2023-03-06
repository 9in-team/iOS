//
//  MainView.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/06.
//

import SwiftUI

struct MainView: View {
    
    @State private var selection = 0
    
    func getColor(isSelected: Bool) -> Color {
        if isSelected {
            return Color(hexcode: "1976D2")
        } else {
            return Color.init(red: 0, green: 0, blue: 0, opacity: 0.6)
        }
    }
    
}

extension MainView {
    
    var body: some View {
        NavigationView {
            BaseView {
                TabView(selection: $selection) {
                    Text("Home")
                        .tabItem {
                            Image("Home")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 20, height: 17)
                                .foregroundColor(getColor(isSelected: selection == 0))
                            
                            Text("홈")
                                .font(.system(size: 12))
                                .foregroundColor(getColor(isSelected: selection == 0))
                        }
                        .tag(0)
                    
                    Text("Subscribe")
                        .tabItem {
                            Image("Subscribe")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 18, height: 18)
                                .foregroundColor(getColor(isSelected: selection == 1))
                            
                            Text("구독")
                                .font(.system(size: 12))
                                .foregroundColor(getColor(isSelected: selection == 1))
                        }
                        .tag(1)
                    
                    Text("MyPost")
                        .tabItem {
                            Image("MyPost")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 22, height: 14)
                                .foregroundColor(getColor(isSelected: selection == 2))
                            
                            Text("내 모집글")
                                .font(.system(size: 12))
                                .foregroundColor(getColor(isSelected: selection == 2))
                        }
                        .tag(2)
                    
                    Text("MyResume")
                        .tabItem {
                            Image("MyResume")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 18, height: 18)
                                .foregroundColor(getColor(isSelected: selection == 3))
                            
                            Text("내 지원서")
                                .font(.system(size: 12))
                                .foregroundColor(getColor(isSelected: selection == 3))
                        }
                        .tag(3)
                }
            }
//            .showNavigationBar(NavigationBar(useDismissButton: false, title: "9in.team"))
            .showNavigationBarTabView(NavigationBar(useDismissButton: false, title: "9in.team"),
                                      NavigationBarTabView(tabList: ["전체", "스터디", "프로젝트"]) { selectedIndex in
                print("selectedIndex: \(selectedIndex)")
            })
        }
    }
    
}
