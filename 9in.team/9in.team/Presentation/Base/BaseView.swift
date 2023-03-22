//
//  BaseView.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/01.
//

import SwiftUI

struct BaseView<Content: View>: View {
         
    @ObservedObject var appState: AppState
    
    @ViewBuilder let content: () -> Content
 
}

extension BaseView {
    
    var body: some View {
        ZStack {
            Color(UIColor.white)
                .edgesIgnoringSafeArea(.all)
                    
            content()
                 
            if appState.alertState {
//                CustomAlert() { alertResultState in
//
//                }
            }
                            
            if appState.loadingState {
                LoadingView()
            }
            
            if appState.toastState {
                Toast(title: appState.toastTitle)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            appState.closeToast()
                        }
                    }
            }
        }
    }
    
}
