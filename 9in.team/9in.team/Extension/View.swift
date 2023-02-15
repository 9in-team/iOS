//
//  View.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/06.
//

import SwiftUI

extension View {
    
    func showNavigationBar(_ navigationBar: NavigationBar) -> some View {        
        GeometryReader { geometry in
            VStack(spacing: 0) {
                navigationBar
                    .frame(height: geometry.size.height / 6.5)
                
                self
            }
        }
    }
    
}
