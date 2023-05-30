//
//  RadioButtonField.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/21.
//

import SwiftUI

struct RadioButtonField: View {
    
    let index: Int
    let title: String
    let isChecked: Bool
    let completion: () -> Void
    
    init(index: Int,
         title: String,
         isChecked: Bool = false,
         completion: @escaping () -> Void) {
        self.index = index
        self.title = title
        self.isChecked = isChecked
        self.completion = completion
    }
    
    var body: some View {
        Button {
            completion()
        } label: {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: isChecked ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 17, height: 17)
                
                TextWithFont(text: title, size: 16)
                    .foregroundColor(
                        Color(hexcode: "000000")
                            .opacity(0.87)
                    )
            }
            .foregroundColor(
                Color(hexcode: "000000")
                    .opacity(0.6)
            )
            .padding(.trailing, 18)
        }
    }
    
}
