//
//  CheckBox.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/26.
//

import SwiftUI

struct CheckBoxStyle: ToggleStyle {
    
    @Environment(\.isEnabled) var isEnabled
    
    let style: Style

    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.\(style.sfSymbolName).fill" : style.sfSymbolName)
                    .resizable()
                    .imageScale(.large)
            }
        })
        .buttonStyle(PlainButtonStyle())
        .disabled(!isEnabled)
    }

    enum Style {
        case square, circle

        var sfSymbolName: String {
            switch self {
            case .square:
                return "square"
            case .circle:
                return "circle"
            }
        }
    }
    
}
