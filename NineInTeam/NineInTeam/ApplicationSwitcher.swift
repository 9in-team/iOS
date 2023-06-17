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
    @ObservedObject private var credentialManager = CredentialManager.shared
    
    var body: some View {
        if credentialManager.isSingIn {
            MainView()
                .environmentObject(coordinator)
                .environmentObject(credentialManager)
                .ignoresSafeArea()
        } else {
            SignInView()
                .ignoresSafeArea()
        }
        
    }
}
