//
//  EmbedCircleImageView.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/13.
//

import SwiftUI

struct EmbedCircleImage: View {
    
    var imageUrl: String = ""
    
    var body: some View {        
        Image(imageUrl)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
    }
    
}
