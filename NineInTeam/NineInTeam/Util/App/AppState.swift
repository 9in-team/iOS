//
//  AppState.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/22.
//

import SwiftUI

class AppState: ObservableObject {
    
    @Published var loadingState: Bool = false
    
    @Published var alertState: Bool = false
    var alertTitle: String = ""
    
    @Published var toastState: Bool = false
    var toastTitle: String = ""
    
    init() {
        print("INIT DEBUG: AppState")
    }
    
    deinit {
        print("DEINIT DEBUG: AppState")
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
        toastTitle = title
        toastState = true
        print("DEBUG Toast: title: \(title), state: \(toastState)")

    }
    
    func closeToast() {
        toastTitle = ""
        toastState = false
        print("DEBUG Toast: \(#function) state: \(toastState)")
    }
    
}
