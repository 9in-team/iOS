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
            
            mainBar()
            
            self
                .padding(.bottom, 10)
                .padding(.horizontal, 10)
                .navigationBarHiddenTrue()
        }
    }
    
    func showTabNavigationBar(_ navigationBar: NavigationBar,
                              _ tabNavigationBar: TabNavigationBar) -> some View {
        VStack(spacing: 0) {
            navigationBar
                .frame(height: 70)
            
            tabNavigationBar
                .frame(height: 40)
            
            mainBar()
            
            self
                .padding(.bottom, 10)
                .padding(.horizontal, 10)
                .navigationBarHiddenTrue()
        }
    }
    
    private func mainBar() -> some View {
        ZStack {
            ColorConstant.main.color()
            
            Rectangle()
                .fill(Color.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
        }
        .frame(height: 20)
    }
    
    func navigationBarHiddenTrue() -> some View {
        self
            .navigationBarTitle("", displayMode: .automatic)
            .navigationBarHidden(true)
    }
    
    func rectangleShadows(firstX: CGFloat, firstY: CGFloat, secondX: CGFloat, secondY: CGFloat) -> some View {
        self
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.white)
                        .shadow(color: Color.init(hexcode: "000000").opacity(0.12),
                                radius: 5, x: firstX, y: firstY)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.white)
                        .shadow(color: Color.init(hexcode: "000000").opacity(0.14),
                                radius: 5, x: secondX, y: secondY)
                }
            )
    }
    
    func circleShadows(firstX: CGFloat, firstY: CGFloat, secondX: CGFloat, secondY: CGFloat) -> some View {
        self
            .background(
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .shadow(color: Color.init(hexcode: "000000").opacity(0.12),
                                radius: 5, x: firstX, y: firstY)
                    
                    Circle()
                        .fill(Color.white)
                        .shadow(color: Color.init(hexcode: "000000").opacity(0.14),
                                radius: 5, x: secondX, y: secondY)
                }
            )
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
    
}
