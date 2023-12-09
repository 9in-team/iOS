//
//  BaseAlert.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/25.
//

import SwiftUI

struct BaseAlert<Content: View>: View {
    
    private let content: Content
    private let bottomPadding: CGFloat

    init(bottomPadding: CGFloat = 60, content: () -> Content) {
        self.bottomPadding = bottomPadding
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.3).ignoresSafeArea()
            
            content
                .padding(.bottom, bottomPadding)
                .frame(maxWidth: 315, maxHeight: 315)
                .background(Color.white)
                .cornerRadius(10)
        }
    }
}
