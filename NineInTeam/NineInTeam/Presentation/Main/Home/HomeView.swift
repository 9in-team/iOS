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
                        coordinator.push(destination: .teamDetail(team.teamId))
                    } label: {
                        TeamCellView(team: team)
                            .padding(.horizontal, 20)
                    }
                }
                .onAppear {
                    viewModel.requestFristPage()
                }
            }

            NavigationLink(destination: WritePostView()) {
                Circle()
                    .frame(width: 56, height: 56)
                    .foregroundColor(ColorConstant.main.color())
                    .circleShadows(firstX: 0, firstY: 1, secondX: 0, secondY: 6)
                    .overlay {
                        Image("Write")
                            .resizable()
                            .frame(width: 18, height: 18)
                    }
            }
            .padding(.trailing, 14)
        }
    }
    
}
