//
//  MainView.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/12.
//

import SwiftUI

struct SignIn: View {
 
    @State var isSignUp = false
    
}

extension SignIn {
    
    var body: some View {
        NavigationView {
            BaseView {
                NavigationLink(destination: SignUp(), isActive: $isSignUp) {
                    Text("SignIn")
                }
            }
        }
        .navigationBarHidden(true)
    }
    
}
