//
//  BaseView.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/01.
//

import SwiftUI

struct BaseView<Content: View>: View {
    
    @StateObject var screenState: ScreenStateSingleton = ScreenStateSingleton.shared
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
}

extension BaseView {
    
    var body: some View {
        ZStack {
            Color(UIColor.clear)
                .edgesIgnoringSafeArea(.all)
                    
            VStack(spacing: 5) {
                Divider()
                
                content
                    .alert(isPresented: $screenState.alertState) {
                        Alert(title: Text(screenState.alertTitle))
                    }
                
                Spacer()
            }
                            
            if screenState.loadingState {
                LoadingView()
            }
            
            if screenState.toastState {
                Toast(title: screenState.toastTitle)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            screenState.closeToast()
                        }
                    }
            }
        }
        .preferredColorScheme(.light)
    }
    
}