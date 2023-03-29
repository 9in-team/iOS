//
//  BaseViewModel.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/01.
//

import Combine
class BaseViewModel: ObservableObject {
    
    let appState: AppState = AppState()

    var cancellables = Set<AnyCancellable>()
    
    init() {
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
        appState.showAlert(title: title)
    }
    
    func showToast(title: String) {
        appState.showToast(title: title)
    }
    
}
