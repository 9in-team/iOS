//
//  BottomNavigationItem.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/13.
//

import SwiftUI

struct BottomNavigationItem: View {
        
    let imageName: String
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let titleName: String
    
    var body: some View {
        VStack(spacing: 5) {
            Spacer()
            
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .frame(width: imageWidth, height: imageHeight)
            
            TextWithFont(text: titleName, font: .regular, size: 12)
        }
        .frame(maxWidth: .infinity)
    }
    
}
