//
//  ChatListView.swift
//  9in.team
//
//  Created by 조상현 on 2023/04/02.
//

import SwiftUI

struct ChatListView: View {
    
    @StateObject var coordinator = Coordinator()
    
    @StateObject var viewModel = ChatListViewModel()
    
}

extension ChatListView {
    
    var body: some View {
        BaseView(appState: viewModel.appState, coordinator: coordinator) {
            mainBody()
                .showNavigationBar(NavigationBar(coordinator: coordinator,
                                                 useDismissButton: true,
                                                 title: "대화방 목록",
                                                 useChatButton: false))
        }
        .onAppear {
            viewModel.getChatRoom()
        }
    }
    
    func mainBody() -> some View {
        ScrollView {            
            VStack {
                ForEach(viewModel.chatRooms, id: \.self) { chatRoom in
                    NavigationLink(destination: ChatDetailView()) {
                        ChatCellView(chatRoom: chatRoom)
                    }
                }
            }
        }
    }
    
}

#if DEBUG
struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatListView()
        }
    }
}
#endif
