//
//  SplashView.swift
//  9in.team
//
//  Created by 조상현 on 2022/12/25.
//

import SwiftUI

struct SplashView: View {
        
    @State var areYouReady = false
    
}

extension SplashView {
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: SignIn(), isActive: $areYouReady) {
                    EmptyView()
                }
                
                Text("9in.team")
                    .onAppear {
                        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2) {
                            areYouReady = true
                        }
                    }
            }
        }
    }
    
}
