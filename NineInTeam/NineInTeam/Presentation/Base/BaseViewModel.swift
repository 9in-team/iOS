//
//  BaseViewModel.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/01.
//

import Combine
import SwiftUI

class BaseViewModel: ObservableObject {
    
    @Published var appState: AppState

    var cancellables = Set<AnyCancellable>()
    
    init(appState: AppState = AppState()) {
        self._appState = Published(initialValue: appState)
        print("init : \(self)")
    }
    
    deinit {
        print("deinit : \(self)")
    }
    
    func willStartLoading() {
        appState.willStartLoading()
    }
    
    func didFinishLoading() {
        appState.didFinishLoading()
    }
    
    func showAlert(title: String) {
        print("DEBUG Alert: \(title)")
        appState.showAlert(title: title)
    }
    
    func showToast(title: String) {
        print("DEBUG Toast: \(title)")
        appState.showToast(title: title)
    }
    
}
