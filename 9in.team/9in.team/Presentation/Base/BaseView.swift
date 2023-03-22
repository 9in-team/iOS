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
                    
            content()
                 
            if appState.alertState {
                CustomAlert(title: appState.alertTitle,
                            usePositiveButton: true,
                            useNegativeButton: true) { alertResultState in
                    // appState.closeAlert()                    
                }
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
