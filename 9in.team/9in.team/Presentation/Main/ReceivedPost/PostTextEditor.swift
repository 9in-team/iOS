//
//  PostTextEditor.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/04/12.
//

import SwiftUI

struct PostTextEditor: View {

    let title: String = "보낼 메시지"
    let cornerRadius: CGFloat = 4
    let fontSize: CGFloat = 16

    @Binding var text: String
    var isDisabled: Bool = false

    var body: some View {
        
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineWidth: 1)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.23)
                )

            TextWithFont(text: title, font: .bold, size: 12)
                .foregroundColor(
                    Color(hexcode: "000000")
                        .opacity(0.6)
                )
                .padding(.horizontal, 5)
                .background(
                    Rectangle()
                        .fill(Color(hexcode: "FFFFFF"))
                )
                .offset(x: 12, y: -5)

            ZStack {
                TextEditor(text: $text)
                    .foregroundColor(
                        Color(hexcode: "000000")
                            .opacity(isDisabled ? 0.38 : 0.87)
                    )
                Text(text)
                    .opacity(0)
                    .padding(.vertical, 8)
            }
            .font(.system(size: fontSize))
            .lineSpacing(fontSize * 1.28 - fontSize)
            .background(Color(hexcode: "FFFFFF"))
            .cornerRadius(cornerRadius)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
        }
    }

}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        ReceivedPostView()
    }
}
