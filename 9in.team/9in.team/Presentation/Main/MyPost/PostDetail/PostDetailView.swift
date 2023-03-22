//
//  PostDetailView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/20.
//

import SwiftUI

struct PostDetailView: View {

    @StateObject var viewModel = MyPostViewModel()
    
}

extension PostDetailView {
    
    var body: some View {
        BaseView(appState: viewModel.appState) {

        }
        .showNavigationBar(NavigationBar(useDismissButton: true, title: "모집글 수정"))
    }
    
}
