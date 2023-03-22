//
//  CustomAlert.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/22.
//

import SwiftUI

struct CustomAlert: View {
    
    let title: String
    let usePositiveButton: Bool
    let useNegativeButton: Bool
    let completion: (AlertResultState) -> Void
    
    // 미정
    enum AlertResultState {
        case aaa
        case bbb
    }
    
    var body: some View {
        ZStack {
            Color.init(hexcode: "000000")
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                TextWithFont(text: title, font: nil, size: 16)
                
                Spacer()
                
                VStack(spacing: 0) {
                    if usePositiveButton {
                        Divider()
                        
                        Button {
                            completion(.aaa)
                        } label: {
                            TextWithFont(text: "확인", font: nil, size: 14)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(height: 60)                        
                    }
                    
                    if useNegativeButton {
                        Divider()
                        
                        Button {
                            completion(.bbb)
                        } label: {
                            TextWithFont(text: "취소", font: nil, size: 14)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(height: 60)
                    }
                }
            }
            .frame(width: 315, height: 315)
            .background(
                Color.init(hexcode: "FFFFFF")
            )
            .cornerRadius(20)
            .padding(30)
        }
    }
    
}
