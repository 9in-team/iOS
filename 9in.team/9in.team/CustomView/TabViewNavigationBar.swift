//
//  NavigationBarTabView.swift
//  9in.team
//
//  Created by ์กฐ์ํ on 2023/03/02.
//

import SwiftUI

struct NavigationBarTabView: View {
                
    let tabList: [String]
    var tabIndexSelectedClosure: (Int) -> Void
    @State var selectedIndex: Int = 0
    let charWidth: CGFloat = 15
    
    var body: some View {
        ZStack {
            ColorConstant.main.color()
                .ignoresSafeArea()
            
            HStack {
                ForEach(Array(zip(tabList.indices, tabList)), id: \.0) { index, tabName in
                    Button {
                        selectedIndex = index
                        tabIndexSelectedClosure(selectedIndex)
                    } label: {
                        VStack(spacing: 2) {
                            Spacer()
                            
                            Text(tabName)
                                .font(.system(size: 20))
                                .foregroundColor(Color.init(hexcode: "FFFFFF")
                                    .opacity(selectedIndex == index ? 1 : 0.3))
                            
                            Rectangle()
                                .frame(width: CGFloat(tabName.count) * charWidth + 20, height: 3)
                                .foregroundColor(Color.init(hexcode: "FFFFFF")
                                    .opacity(selectedIndex == index ? 1 : 0))
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .padding(.horizontal, 10)
        }
    }
    
}
