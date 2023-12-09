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
        DispatchQueue.main.async {
            self.loadingState = true
        }
    }
    
    func didFinishLoading() {
        DispatchQueue.main.async {
            self.loadingState = false
        }
    }
    
    func showAlert(title: String) {
        DispatchQueue.main.async {
            self.alertState = true
            self.alertTitle = title
        }
    }
    
    func closeAlert() {
        DispatchQueue.main.async {
            self.alertState = false
            self.alertTitle = ""
        }
    }
    
    func showToast(title: String) {
        DispatchQueue.main.async {
            self.toastTitle = title
            self.toastState = true
            print("DEBUG Toast: title: \(title), state: \(self.toastState)")
        }

    }
    
    func closeToast() {
        DispatchQueue.main.async {
            self.toastTitle = ""
            self.toastState = false
            print("DEBUG Toast: \(#function) state: \(self.toastState)")
        }
    }
    
}
