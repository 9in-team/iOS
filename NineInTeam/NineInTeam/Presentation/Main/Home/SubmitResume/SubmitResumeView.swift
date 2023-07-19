//
//  SubmitResumeView.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/07/19.
//

import SwiftUI

struct SubmitResumeView: View {

    @EnvironmentObject var coordinator: Coordinator
    
    @StateObject var viewModel = HomeViewModel()
    
}

extension SubmitResumeView {
    
    var body: some View {
        BaseView(appState: viewModel.appState, coordinator: coordinator) {
            mainBody()
                .showNavigationBar(NavigationBar(coordinator: coordinator,
                                                 useDismissButton: true,
                                                 title: "지원하기"))
        }
        .onAppear {
            
        }
    }
    
    func mainBody() -> some View {
        VStack {
            Text("지원하기")
        }
    }
    
}
