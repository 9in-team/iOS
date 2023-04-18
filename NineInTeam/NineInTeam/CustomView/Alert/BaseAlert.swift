//
//  BaseAlert.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/25.
//

import SwiftUI

struct BaseAlert<Content: View>: View {
    
    let content: Content

    init(content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).ignoresSafeArea()
            
            content
                .padding(.bottom, 60)
                .frame(maxWidth: 315, maxHeight: 315)
                .background(Color.white)
                .cornerRadius(10)
        }
    }
}
