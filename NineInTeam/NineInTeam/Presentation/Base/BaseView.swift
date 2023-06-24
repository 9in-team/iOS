//
//  BaseView.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/01.
//

import SwiftUI

struct BaseView<Content: View>: View {
         
    @ObservedObject var appState: AppState
    @ObservedObject var coordinator: Coordinator
    
    let content: Content
    
    // TODO: BaseView를 사용하는 모든 뷰에서 coordinator 패턴 적용하면 아래 주석 생성자 사용
    // 1init(appState: AppState, coordinator: Coordinator, content: () -> Content) {
    init(appState: AppState, coordinator: Coordinator = Coordinator(), content: () -> Content) {
        self.appState = appState
        self.coordinator = coordinator
        self.content = content()
    }
    
}

extension BaseView {
    
    var body: some View {
        ZStack {
            coordinator.navigationLinkSection()
            
            Color(UIColor.white)
                    
            content
                 
            if appState.alertState {
                DefaultAlert(title: appState.alertTitle) {
                    appState.closeAlert()
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
