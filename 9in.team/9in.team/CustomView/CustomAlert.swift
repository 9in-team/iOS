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
    
    enum AlertResultState {
        case a // 미정
        case b // 미정
    }
    
    var body: some View {
        ZStack {
            Color.init(hexcode: "000000")
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text(title)
                
                Spacer()
                
                VStack(spacing:0) {
                    if usePositiveButton {
                        Divider()
                        
                        Button {
                            //
                        } label: {
                            Text("확인")
                                .font(.system(size: 16, weight: .bold))
                        }
                        .frame(height: 60)
                    }
                    
                    if useNegativeButton {
                        Divider()
                        
                        Button {
                            //
                        } label: {
                            Text("취소")
                                .font(.system(size: 16, weight: .bold))
                        }
                        .frame(height: 60)
                    }
                }
            }
            .frame(width: 300, height: 350)
            .background(
                Color.init(hexcode: "FFFFFF")
            )
            .cornerRadius(10)
            .padding(30)
        }
    }
    
}
