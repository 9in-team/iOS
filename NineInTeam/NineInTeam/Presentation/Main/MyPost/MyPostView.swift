//
//  MyPostView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/14.
//

import SwiftUI

struct MyPostView: View {

    @StateObject var viewModel = MyPostViewModel()
    
}

extension MyPostView {
    
    var body: some View {
        BaseView(appState: viewModel.appState) {
            mainBody()
                .showNavigationBar(NavigationBar(useDismissButton: false, title: "9in.team"))
        }
    }
    
    func mainBody() -> some View {
        ScrollView {
            Rectangle()
                .frame(height: 0.1)
                .foregroundColor(Color.clear)
            
            PostCellView(post: Post(badge: 1))
            
            PostCellView(post: Post(badge: 0))
        }
    }
                
}
