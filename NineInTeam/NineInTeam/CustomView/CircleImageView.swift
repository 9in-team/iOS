//
//  CircleImageView.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/26.
//

import SwiftUI

struct CircleImage: View {
    
    var image: UIImage?
    
    var body: some View {
        if image == nil {
            Circle()
                .foregroundColor(Color(hexcode: "D9D9D9"))                
        } else {
            Image(uiImage: image!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
        }
    }
    
}
