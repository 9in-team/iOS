//
//  File.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/28.
//

import SwiftUI

struct ApplicationSwitcher: View {
    
    @StateObject var viewModel = SignViewModel()

    @StateObject var coordinator = Coordinator(isRoot: true)

    @ObservedObject private var userAuthManager = UserAuthManager.shared
    
    var body: some View {
        
        Group {
            if userAuthManager.isSingIn {
                MainView()
                    .onAppear {
                        viewModel.getLoginSession()
                        coordinator.popToRoot()
                    }
            } else {
                SignInView()
            }
        }
        .ignoresSafeArea()
        .environmentObject(coordinator)
        .environmentObject(userAuthManager)

    }
    
}
