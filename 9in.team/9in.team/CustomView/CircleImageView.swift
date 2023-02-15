//
//  CircleImageView.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/13.
//

import SwiftUI

struct CircleImage: View {
    
    var imageUrl: String = ""
    
    var body: some View {
        if imageUrl.isEmpty {
            Image("emptyImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
        } else {
            Image(imageUrl)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
        }
    }
    
}
