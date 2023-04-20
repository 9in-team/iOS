//
//  AvailableNavigation.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/04/20.
//

import SwiftUI

struct AvailableNavigation<Content: View>: View {
    
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        if #available(iOS 16, *) {
            NavigationStack(root: content)
        } else {
            NavigationView(content: content)
        }
    }
    
}
