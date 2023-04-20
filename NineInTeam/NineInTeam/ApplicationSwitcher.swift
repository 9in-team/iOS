//
//  File.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/28.
//

import SwiftUI

struct ApplicationSwitcher: View {
    
    @StateObject var viewModel = SignViewModel()
    
    var body: some View {
        if viewModel.isSingIn {
                MainView()
        } else {
            SignInView()
                .onAppear {
                    viewModel.autoLogin()
                }
        }
        
    }
}
