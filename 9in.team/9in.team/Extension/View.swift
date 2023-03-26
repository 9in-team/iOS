//
//  View.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/06.
//

import UIKit
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
    
    func alert<Content>(isPresented: Binding<Bool>, alert: () -> BaseAlert<Content>) -> some View where Content: View {
        let keyWindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene}).compactMap {$0}.first?.windows.filter { $0.isKeyWindow }.first!
        
        let viewController = UIHostingController(rootView: alert())
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.view.backgroundColor = .clear
        viewController.definesPresentationContext = true
        
        return self.onChange(of: isPresented.wrappedValue, perform: {
            if $0 {
                keyWindow?.rootViewController?.present(viewController, animated: true)
            } else {
                keyWindow?.rootViewController?.dismiss(animated: true)
            }
        })
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
    
}
