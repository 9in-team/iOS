//
//  BorderedTextEditorWithTitle.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 8/18/23.
//

import SwiftUI

struct BorderedTextEditorWithTitle: View {
    
    private let title: String
    private let textColor: Color
    private let strokeColor: Color
    private let backgroundColor: Color
    private let cornerRadius: CGFloat
    private let minHeight: CGFloat
    private let maxHeight: CGFloat
    
    @Binding private var text: String
    
    init(title: String,
         text: Binding<String>,
         textColor: Color = Color(hexcode: "000000").opacity(0.6),
         strokeColor: Color = Color(hexcode: "000000").opacity(0.23),
         backgroundColor: Color = Color(hexcode: "FFFFFF"),
         cornerRadius: CGFloat = 4,
         minHeight: CGFloat = 64,
         maxHeight: CGFloat = 230
    ) {
        self.title = title
        self._text = text
        self.textColor = textColor
        self.strokeColor = strokeColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.minHeight = minHeight
        self.maxHeight = maxHeight
    }
    
}

extension BorderedTextEditorWithTitle {
    
    var body: some View {
        ZStack(alignment: .leading) {
            border
            
            titleView
            
            textEditor
        }
        .frame(minHeight: minHeight, maxHeight: maxHeight)
        .frame(maxWidth: .infinity)
    }
    
    private var titleView: some View {
        VStack {
            TextWithFont(text: title, font: .robotoBold, size: 12)
                .foregroundColor(textColor)
                .padding(.horizontal, 5)
                .background(background)
                .offset(x: 12, y: -5)
            
            Spacer()
        }
    }
    
    private var textEditor: some View {
        TextEditor(text: $text)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .textCase(.none)
            .padding(.vertical, 16)
            .padding(.horizontal, 12)
    }
    
    private var border: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(strokeColor)
    }
    
    private var background: some View {
        Rectangle()
            .fill(backgroundColor)
    }
}

#if DEBUG
struct TextEditorWithTitle_Previews: PreviewProvider {
    
    static let text = "TextEditor는 긴 형식의 텍스트를 표시하고 편집할 수 있는 View입니다."
    static let text2 = "TextEditor를 사용하면 앱의 사용자 인터페이스에서 스크롤 가능한 여러 줄 텍스트를 표시하고 편집할 수 있습니다."
    static let text3 = "텍스트 편집기 보기를 사용하면 앱의 사용자 인터페이스에서 스크롤 가능한 여러 줄 텍스트를 표시하고 편집할 수 있습니다."
    static let text4 = "기본적으로 텍스트 편집기 보기는 font(_:), foregroundColor(_:)"
    static let text5 = "및 multilineTextAlignment(_:)와 같은 환경에서 상속된 특성을 사용하여 텍스트 스타일을 지정합니다."
    static let text6 = "보기 본문에 TextEditor 인스턴스를 추가하여 텍스트 편집기를 만들고 Binding을 앱의 문자열 변수에 전달하여 초기화합니다."

    static var previews: some View {
        BorderedTextEditorWithTitle(title: "텍스트 에디터", text: .constant(text + text2 + text3 + text4 + text5 + text6))
    }
}
#endif
