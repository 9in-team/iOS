//
//  ChatDetailView.swift
//  9in.team
//
//  Created by Heonjin Ha on 2023/04/03.
//

import SwiftUI

struct ChatDetailView: View {

    @StateObject var viewModel = ChatDetailViewModel()

    var title: String = "최강헌"
    @State var userInputText: String = "하이"

}

extension ChatDetailView {

    var body: some View {
        BaseView(appState: viewModel.appState) {
            VStack(spacing: 0) {
                ScrollView {
                    ChatBubbleView(direction: .left) {
                        TextWithFont(text: "형 하이", font: .light, size: 16)
                    }

                    ChatBubbleView(direction: .right) {
                        TextWithFont(text: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ", font: .light, size: 16)
                    }
                }
                .showNavigationBar(NavigationBar(useDismissButton: true, title: title, useChatButton: false))

                inputField
                    .padding(.leading, 20)
                    .padding(.trailing, 12)
            }
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
                Image("Paperplane")
                    .frame(width: 24, height: 24)
            }
            .frame(width: 48, height: 48)
        }
        .frame(height: 56)
    }

}
