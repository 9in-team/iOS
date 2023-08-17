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

    @ObservedObject private var authManager = AuthManager.shared
    
    var body: some View {
        
        Group {
//            if authManager.isSingIn {
                MainView()
                    .onAppear {
                        coordinator.popToRoot()
                        viewModel.kakaoLoginWithSession { error in
                            if let error = error {
                                print("DEBUG: 세션가져오기 오류 \(error)")
                                return
                            }
                        }
                    }
//            } else {
//                SignInView()
//            }
        }
        .ignoresSafeArea()
        .environmentObject(coordinator)
        .environmentObject(authManager)

    }
    
}
