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
                .background(direction == .left ? Color(hexcode: "D9D9D9") : Color(hexcode: "BBDEFB") )
                .clipShape(ChatBubbleShape(direction: direction))
                .overlay {
                    GeometryReader { proxy in
                        if direction == .right {
                            Path { path in
                                path.move(to: CGPoint(x: proxy.size.width - 1.5, y: proxy.size.height - 17))
                                path.addLine(to: CGPoint(x: proxy.size.width + 12, y: proxy.size.height))
                                path.addLine(to: CGPoint(x: -1.5, y: proxy.size.height))
                                path.addLine(to: CGPoint(x: proxy.size.width - 2, y: proxy.size.height))
                            }
                            .fill(Color(hexcode: "BBDEFB"))
                        }

                        if direction == .left {
                            Path { path in
                                path.move(to: CGPoint(x: 1.5, y: proxy.size.height - 17))
                                path.addLine(to: CGPoint(x: -12, y: proxy.size.height))
                                path.addLine(to: CGPoint(x: 1.5, y: proxy.size.height))
                                path.addLine(to: CGPoint(x: 1.5, y: proxy.size.height - 17))
                            }
                            .fill(Color(hexcode: "D9D9D9"))
                        }
                    }
                }

            if direction == .left {
                Spacer()
            }
        }
        .padding([(direction == .left) ? .leading : .trailing], 21)
        .padding((direction == .right) ? .leading : .trailing, 50)
        .padding([.top, .bottom], 11)
    }

}
