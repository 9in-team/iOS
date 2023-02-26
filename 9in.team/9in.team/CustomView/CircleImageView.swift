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
            Image("emptyImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
        } else {
            Image(uiImage: image!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
        }
    }
    
}
