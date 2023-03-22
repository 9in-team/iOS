//
//  PostDetailView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/20.
//

import SwiftUI

struct PostDetailView: View {

    let team: Team
    
}

extension PostDetailView {
    
    var body: some View {
        BaseView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    
                }
                .padding(.horizontal, 20)
            }
        }
        .showNavigationBar(NavigationBar(useDismissButton: true, title: "모집글 수정"))
    }
    
}
