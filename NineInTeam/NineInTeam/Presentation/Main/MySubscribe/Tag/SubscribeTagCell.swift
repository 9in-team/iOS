//
//  SubscribeTagCell.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/04/20.
//

import SwiftUI

struct SubscribeTagCell: View {

    @Binding var subscribing: Bool

}

extension SubscribeTagCell {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color(hexcode: "FFFFFF"))
                .shadow(color: Color(hexcode: "E0E0E0"),
                        radius: 1, x: 0, y: 0)
                .frame(height: 65)

            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    TextWithFont(text: "#알고리즘", font: .regular, size: 16)
                        .frame(height: 24)

                    TextWithFont(text: "구독자 123명", font: .regular, size: 12)
                        .foregroundColor(Color(hexcode: "000000").opacity(0.38))
                        .frame(height: 20)
                }
                .padding(.leading, 18)

                Spacer()

                subscribeStateButton()
            }
        }
    }

    func subscribeStateButton() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: 89, height: 65)
                .foregroundColor(Color(hexcode: isSubscribe ? "C7C7CC" : "42A5F5"))
                .rectangleShadows(firstX: 0, firstY: 1, secondX: 0, secondY: 2, secondRadius: 2)

            TextWithFont(text: isSubscribe ? "구독중" : "구독하기", font: .medium, size: 13)
                .foregroundColor(Color(hexcode: "FFFFFF"))
        }
    }

}

struct SubscribeTagCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SubscribeTagCell(isSubscribe: .constant(false))
            SubscribeTagCell(isSubscribe: .constant(true))
        }
    }
}
