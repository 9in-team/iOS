//
//  ScreenStateSingleton.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/01.
//

import SwiftUI

class ScreenStateSingleton: ObservableObject {
    
    static let shared = ScreenStateSingleton()
    
    @Published var loadingState: Bool = false
    
    @Published var alertState: Bool = false
    var alertTitle: String = ""
    
    @Published var toastState: Bool = false
    var toastTitle: String = ""
    
    private init() {
        
    }
    
    func willStartLoading() {
        loadingState = true
    }
    
    func didFinishLoading() {
        loadingState = false
    }
    
    func showAlert(title: String) {
        alertState = true
        alertTitle = title
    }
    
    func closeAlert() {
        alertState = false
        alertTitle = ""
    }
    
    func showToast(title: String) {
        toastState = true
        toastTitle = title
    }
    
    func closeToast() {
        toastState = false
        toastTitle = ""
    }
    
}
