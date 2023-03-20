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
            
            ZStack {
                ColorConstant.main.color()
                
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            .frame(height: 20)
            
            self
                .padding(.bottom, 10)
                .padding(.horizontal, 10)
                .navigationBarTitle("", displayMode: .automatic)
                .navigationBarHidden(true)
        }
    }
    
    func showTabNavigationBar(_ navigationBar: NavigationBar,
                              _ tabNavigationBar: TabNavigationBar) -> some View {
        VStack(spacing: 0) {
            navigationBar
                .frame(height: 70)
            
            tabNavigationBar
                .frame(height: 40)
            
            ZStack {
                ColorConstant.main.color()
                
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            .frame(height: 20)
            
            self
                .padding(.bottom, 10)
                .padding(.horizontal, 10)
                .navigationBarTitle("", displayMode: .automatic)
                .navigationBarHidden(true)
        }
    }
        
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
    
}
