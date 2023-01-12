//
//  BaseViewModel.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/01.
//

import Combine

class BaseViewModel: ObservableObject {
    let state = ScreenStateSingleton.shared
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        print("init : \(self)")
    }
    
    deinit {
        print("deinit : \(self)")
    }
    
    func willStartLoading() {
        state.willStartLoading()
    }
    
    func didFinishLoading() {
        state.didFinishLoading()
    }
    
    func showToast(title: String) {
        state.showToast(title: title)
    }
    
    func showAlert(title: String) {
        state.showAlert(title: title)
    }
}
