//
//  LoadingView.swift
//  9in.team
//
//  Created by 조상현 on 2023/01/01.
//

import SwiftUI

struct LoadingView: View {
    let title: String = "로딩중 . . ."
}

extension LoadingView {
    var body: some View {
        ZStack {
            Color(UIColor.clear)
            
            ProgressView()
                .scaleEffect(2.0, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: Color(UIColor.systemBackground)))
                .frame(width: 80, height: 80)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill()
                )
        }
    }
}
