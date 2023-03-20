//
//  HomeView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/07.
//

import SwiftUI

struct HomeView: View {

    @StateObject var viewModel = HomeViewModel()
    
    @State var currentTab: Int = 0
    
}

extension HomeView {
    
    var body: some View {
        BaseView {
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    Rectangle()
                        .frame(height: 0.1)
                        .foregroundColor(Color.clear)
                    
                    ForEach(viewModel.teams, id: \.teamId) { team in
                        NavigationLink(destination: TeamDetailView(team: team)) {
                            TeamView(team: team)
                        }
                    }
                }
            }
        }
        .showTabNavigationBar(NavigationBar(useDismissButton: false, title: "9in.team"),
                                  TabNavigationBar(tabList: ["전체", "스터디", "프로젝트"]) { selectedIndex in
            currentTab = selectedIndex
        })
        .onAppear {
            viewModel.requestFristPage()
        }
    }
    
}
