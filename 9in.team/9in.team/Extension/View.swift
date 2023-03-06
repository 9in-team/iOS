//
//  View.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/06.
//

import SwiftUI

extension View {
    
    func showNavigationBar(_ navigationBar: NavigationBar) -> some View {
        VStack(spacing: 0) {
            navigationBar
                .frame(height: 70)
            
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .frame(height: 20)
            
            self
            //                    .navigationBarTitle("", displayMode: .automatic)
            //                    .navigationBarHidden(true) 
        }
    }
    
    func showNavigationBarTabView(_ navigationBar: NavigationBar,
                                  _ navigationBarTabView: NavigationBarTabView) -> some View {
        VStack(spacing: 0) {
            navigationBar
                .frame(height: 70)
            
            navigationBarTabView
                .frame(height: 40)
            
            Rectangle()
                .fill(Color.white)
                .frame(height: 20)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            
            self
            //                    .navigationBarTitle("", displayMode: .automatic)
            //                    .navigationBarHidden(true)
        }
    }
        
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
    
}
