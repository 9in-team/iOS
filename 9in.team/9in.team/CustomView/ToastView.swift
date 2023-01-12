//
//  ToastView.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/01.
//

import SwiftUI

struct Toast: View {
    
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
}

extension Toast {
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(title)
                .padding(5)
                .background(Color(UIColor.label))
                .border(Color(UIColor.label))
                .cornerRadius(10)
                .foregroundColor(Color(UIColor.systemBackground))
        }
        
    }
    
}
