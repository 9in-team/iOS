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
            Color(UIColor.white)
                .edgesIgnoringSafeArea(.all)
                    
            VStack(spacing: 5) {                
                content
                    .alert(isPresented: $screenState.alertState) {
                        Alert(title: Text(screenState.alertTitle))
                              // customAlert 만들기
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
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
    
}
