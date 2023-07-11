//
//  ChatDetailView.swift
//  9in.team
//
//  Created by Heonjin Ha on 2023/04/03.
//

import SwiftUI

struct ChatDetailView: View {

    @StateObject var viewModel = ChatDetailViewModel()

    let chatId: Int
    var title: String = "최강헌"
    @State var userInputText: String = "같이 고고"

}

extension ChatDetailView {

    var body: some View {
        BaseView(appState: viewModel.appState) {
            mainBody()
        }
        .showNavigationBar(NavigationBar(useDismissButton: true, title: title, useChatButton: false))
        .onAppear {
            viewModel.getChatDetail(chatId: chatId)
        }
    }

    func mainBody() -> some View {
        VStack(spacing: 0) {
            ScrollView {
                ForEach(viewModel.chats, id: \.self) { chat in
                    if viewModel.userId == chat.userId {
                        ChatBubbleView(direction: .right) {
                            TextWithFont(text: chat.message, size: 16)
                        }
                    } else {
                        ChatBubbleView(direction: .left) {
                            TextWithFont(text: chat.message, size: 16)
                        }
                    }
                }
            }

            inputField
                .padding(.leading, 20)
                .padding(.trailing, 12)
        }
    }

    var inputField: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 1)
                    .foregroundColor(Color(hexcode: "000000"))
                    .opacity(0.23)

                TextField("", text: $userInputText)
                    .font(.system(size: 16))
                    .padding(.horizontal, 8)
            }
            .frame(height: 40)

            Button {
                print("\(userInputText)")
                userInputText = ""
            } label: {
                ZStack {
                    Image("Send")
                        .resizable()
                        .frame(width: 21, height: 18)
                }
                .frame(width: 24, height: 24)
            }
            .frame(width: 48, height: 48)
        }
        .frame(height: 56)
    }

}

#if DEBUG
struct ChatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatDetailView(chatId: 0)
        }
    }
}
#endif
