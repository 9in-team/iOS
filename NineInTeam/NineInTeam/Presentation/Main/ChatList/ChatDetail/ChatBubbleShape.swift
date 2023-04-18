//
//  ChatBubbleShape.swift
//  9in.team
//
//  Created by Heonjin Ha on 2023/04/04.
//

import SwiftUI

struct ChatBubbleShape: Shape {
    
    enum Direction {
        case left
        case right
    }

    let direction: Direction

    func path(in rect: CGRect) -> Path {
        return (direction == .left) ? getLeftBubblePath(in: rect) : getRightBubblePath(in: rect)
    }

    private func getLeftBubblePath(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let path = Path { path in
            let cornerRadius: CGFloat = 5

            path.move(to: CGPoint(x: 0, y: cornerRadius))
            path.addLine(to: CGPoint(x: 0, y: height))

            path.addLine(to: CGPoint(x: width - cornerRadius, y: height))
            path.addCurve(to: CGPoint(x: width, y: height - cornerRadius),
                          control1: CGPoint(x: width - cornerRadius / 2, y: height),
                          control2: CGPoint(x: width, y: height - cornerRadius / 2))
            path.addLine(to: CGPoint(x: width, y: cornerRadius))

            path.addCurve(to: CGPoint(x: width - cornerRadius, y: 0),
                          control1: CGPoint(x: width, y: cornerRadius / 2),
                          control2: CGPoint(x: width - cornerRadius / 2, y: 0))
            path.addLine(to: CGPoint(x: cornerRadius, y: 0))

            path.addCurve(to: CGPoint(x: 0, y: cornerRadius),
                          control1: CGPoint(x: cornerRadius / 2, y: 0),
                          control2: CGPoint(x: 0, y: cornerRadius / 2))
        }
        return path
    }

    private func getRightBubblePath(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let path = Path { path in
            let cornerRadius: CGFloat = 5
            path.move(to: CGPoint(x: 0, y: cornerRadius))
            path.addLine(to: CGPoint(x: 0, y: height - cornerRadius))
            path.addCurve(to: CGPoint(x: cornerRadius, y: height),
                          control1: CGPoint(x: 0, y: height - cornerRadius / 2),
                          control2: CGPoint(x: cornerRadius / 2, y: height))

            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: width, y: cornerRadius))

            path.addCurve(to: CGPoint(x: width - cornerRadius, y: 0),
                          control1: CGPoint(x: width, y: cornerRadius / 2),
                          control2: CGPoint(x: width - cornerRadius / 2, y: 0))
            path.addLine(to: CGPoint(x: cornerRadius, y: 0))

            path.addCurve(to: CGPoint(x: 0, y: cornerRadius),
                          control1: CGPoint(x: cornerRadius / 2, y: 0),
                          control2: CGPoint(x: 0, y: cornerRadius / 2))
        }
        return path
    }
    
}
