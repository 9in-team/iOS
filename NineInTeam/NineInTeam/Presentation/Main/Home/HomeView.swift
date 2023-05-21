//
//  HomeView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/07.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var coordinator: Coordinator
    
    @StateObject var viewModel = HomeViewModel()
    
    @State var currentTab: Int = 0
    
}

extension HomeView {
    
    var body: some View {
        BaseView(appState: viewModel.appState, coordinator: coordinator) {
            mainBody()
                .showTabNavigationBar(NavigationBar(coordinator: coordinator,
                                                    useDismissButton: false,
                                                    title: "9in.team"),
                                      TabNavigationBar(tabList: ["전체", "스터디", "프로젝트"]) { selectedIndex in
                    currentTab = selectedIndex
                })
        }
        .onAppear {
            viewModel.requestFristPage()
        }
    }
    
    func mainBody() -> some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView(showsIndicators: false) {
                Rectangle()
                    .frame(height: 0.1)
                    .foregroundColor(Color.clear)
                
                ForEach(viewModel.teams, id: \.teamId) { team in
                    Button {
                        coordinator.push(destination: .teamDetail(team))
                    } label: {
                        TeamCellView(team: team)
                    }
                }
            }
            
            NavigationLink(destination: WritePostView()) {
                Circle()
                    .frame(width: 56, height: 56)
                    .foregroundColor(ColorConstant.main.color())                    
                    .circleShadows([Shadow(color: .black, opacity: 0.12, radius: 18, locationY: 1),
                                    Shadow(color: .black, opacity: 0.14, radius: 10, locationY: 6),
                                    Shadow(color: .black, opacity: 0.2, radius: 5, locationY: 3)])
                    .overlay {
                        Image("Write")
                            .resizable()
                            .frame(width: 18, height: 18)
                    }
            }
            .padding(.trailing, 5)
        }
    }
    
}
