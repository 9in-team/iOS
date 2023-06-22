//
//  MyWishView.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/06/21.
//

import SwiftUI

struct MyWishView: View {
    
    @StateObject var coordinator: Coordinator = Coordinator()
    
    @StateObject var viewModel = MyWishViewModel()
    
}

extension MyWishView {
    
    var body: some View {
        BaseView(appState: viewModel.appState, coordinator: coordinator) {
            mainBody()
                .showNavigationBar(NavigationBar(coordinator: coordinator,
                                                 useDismissButton: true,
                                                 title: "찜"))
        }
        .onAppear {
            viewModel.requestFristPage()
        }
    }
    
    func mainBody() -> some View {
        ScrollView(showsIndicators: false) {
            Rectangle()
                .frame(height: 0.1)
                .foregroundColor(Color.clear)
            
            ForEach(viewModel.myWishList, id: \.teamId) { myWish in
                Button {
                    coordinator.push(destination: .teamDetail(myWish.teamId))
                } label: {
                    TeamCellView(team: myWish) // <- 현재 api 명세서에서는 wish 모델에 leader가 없음, 임시로 leader 넣어둠
                        .padding(.horizontal, 20)
                }
            }
        }
    }
    
}
