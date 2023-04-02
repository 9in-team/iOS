//
//  ChatListView.swift
//  9in.team
//
//  Created by 조상현 on 2023/04/02.
//

import SwiftUI

struct ChatListView: View {
    
    @StateObject var viewModel = ChatListViewModel()
    
}

extension ChatListView {
    
    var body: some View {
        BaseView(appState: viewModel.appState) {
            mainBody()
                .showNavigationBar(NavigationBar(useDismissButton: true, title: "대화방 목록", useChatButton: false))
        }
    }
    
    func mainBody() -> some View {
        ScrollView {
            VStack {
                ChatCellView()                    
                
                ChatCellView()
            }                        
        }
    }
    
}
