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
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(height: 20)
                    .offset(x: 0, y: -10)
                
                Spacer()
            }
            
            Color(UIColor.white)
                .edgesIgnoringSafeArea(.all)
                    
            VStack(spacing: 5) {
                content
                    .alert(isPresented: $screenState.alertState) {
                        Alert(title: Text(screenState.alertTitle))
                            // TODO: disapper 
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
