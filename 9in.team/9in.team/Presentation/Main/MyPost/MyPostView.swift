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
        BaseView {
            VStack(spacing: 0) {
                ScrollView {
                    Rectangle()
                        .frame(height: 0.1)
                        .foregroundColor(Color.clear)
                    
                    PostView(post: Post(badge: 1))
                    
                    PostView(post: Post(badge: 0))
                }
            }
        }
        .showNavigationBar(NavigationBar(useDismissButton: false, title: "9in.team"))
    }
                
}
