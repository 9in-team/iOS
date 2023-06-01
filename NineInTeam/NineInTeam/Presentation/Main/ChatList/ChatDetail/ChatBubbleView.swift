//
//  ChatBubbleView.swift
//  9in.team
//
//  Created by Heonjin Ha on 2023/04/03.
//

import SwiftUI

struct ChatBubbleView<Content>: View where Content: View {

    let direction: ChatBubbleShape.Direction
    let content: () -> Content
    let bubbleColor: (left: Color, right: Color) = (Color(hexcode: "D9D9D9"), Color(hexcode: "BBDEFB"))

    init(direction: ChatBubbleShape.Direction, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.direction = direction
    }

}

extension ChatBubbleView {

    var body: some View {
        HStack {
            if direction == .right {
                Spacer()
            }

            content()
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(direction == .left ? bubbleColor.left : bubbleColor.right )
                .clipShape(ChatBubbleShape(direction: direction))
                .overlay {
                    GeometryReader { proxy in
                        let width = proxy.size.width
                        let height = proxy.size.height

                        if direction == .right {
                            Path { path in
                                path.move(to: CGPoint(x: width - 1.5, y: height - 17))
                                path.addLine(to: CGPoint(x: width + 12, y: height))
                                path.addLine(to: CGPoint(x: -1.5, y: height))
                                path.addLine(to: CGPoint(x: width - 2, y: height))
                            }
                            .fill(bubbleColor.right)
                        }

                        if direction == .left {
                            Path { path in
                                path.move(to: CGPoint(x: 1.5, y: height - 17))
                                path.addLine(to: CGPoint(x: -12, y: height))
                                path.addLine(to: CGPoint(x: 1.5, y: height))
                                path.addLine(to: CGPoint(x: 1.5, y: height - 17))
                            }
                            .fill(bubbleColor.left)
                        }
                    }
                }

            if direction == .left {
                Spacer()
            }
        }
        .padding((direction == .left) ? .leading : .trailing, 11 + 24)
        .padding((direction == .right) ? .leading : .trailing, 83)
        .padding(.vertical, 11)
    }

}

#if DEBUG
struct ChatBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetailView()
        ChatBubbleView(direction: .left) {
            TextWithFont(text: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ", font: .robotoRegular, size: 16)
        }
        ChatBubbleView(direction: .right) {
            TextWithFont(text: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ", font: .robotoRegular, size: 16)
        }
    }
}
#endif
