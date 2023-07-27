//
//  View.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/06.
//

import UIKit
import SwiftUI

extension View {
    
    func showNavigationBar(_ navigationBar: some View) -> some View {
        VStack(spacing: 0) {
            navigationBar
                .frame(height: 70)
            
            mainBar()
            
            self
                .padding(.bottom, 10)
                .background(Color(hexcode: "FFFFFF"))
                .navigationBarHiddenTrue()
            
            Spacer()
        }
    }
    
    func showTabNavigationBar(_ navigationBar: some View,
                              _ tabNavigationBar: TabNavigationBar) -> some View {
        VStack(spacing: 0) {
            navigationBar
                .frame(height: 70)
            
            tabNavigationBar
                .frame(height: 40)
            
            mainBar()
            
            self
                .padding(.bottom, 10)
                .background(Color(hexcode: "FFFFFF"))
                .navigationBarHiddenTrue()
            
            Spacer()
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

    func rectangleShadows(cornerRadius: CGFloat = 0, _ shadows: [Shadow]) -> some View {
        self
            .background(
                ZStack {
                    ForEach(shadows, id: \.self) { shadow in
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(.white.opacity(0.01))
                            .shadow(color: shadow.getColor(), radius: shadow.radius,
                                    x: shadow.locationX, y: shadow.locationY)
                    }
                }
            )
    }
    
    func circleShadows(_ shadows: [Shadow]) -> some View {
        self
            .background(
                ZStack {
                    ForEach(shadows, id: \.self) { shadow in
                        Circle()
                            .fill(.white)
                            .shadow(color: shadow.getColor(), radius: shadow.radius,
                                    x: shadow.locationX, y: shadow.locationY)
                    }
                }
            )
    }
    
    // LoadingView, Alert, Toast
    func drawOnRootViewController<Content>(isPresented: Binding<Bool>,
                                           view: () -> Content) -> some View where Content: View {
        let keyWindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene}).compactMap {$0}.first?.windows.filter { $0.isKeyWindow }.first!
        
        let viewController = UIHostingController(rootView: view())
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
