//
//  HomeView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/07.
//

import SwiftUI

struct HomeView: View {

    @StateObject var viewModel = HomeViewModel()
    
}

extension HomeView {
    
    var body: some View {
        BaseView {
            VStack(spacing: 0) {
                ScrollView {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.clear)
                    
                    ForEach(viewModel.teams, id: \.teamId) { team in
                        Button {
                            print("")
                        } label: {
                            TeamView(team: team)
                        }
                        
                    }
                }
            }
        }
        .onAppear {
            viewModel.requestFristPage()
        }
    }
    
}
