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
    @ObservedObject private var authManager = UserAuthManager.shared
    
    var body: some View {
        if authManager.isSingIn {
            MainView()
                .environmentObject(coordinator)
                .environmentObject(authManager)
                .ignoresSafeArea()
        } else {
            SignInView()
                .ignoresSafeArea()
        }
        
    }
}
