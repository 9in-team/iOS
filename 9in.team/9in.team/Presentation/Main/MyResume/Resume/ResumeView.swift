//
//  ResumeView.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/19.
//

import SwiftUI

struct ResumeView: View {

    let resume: Resume
    
    func applyStateTitle() -> String {
        var title = ""
        if resume.applyState == .waiting {
            title = "대기중"
        } else if resume.applyState == .invited {
            title = "초대됨"
        } else if resume.applyState == .rejected {
            title = "거절됨"
        }
        return title
    }
    
    func applyStateColor() -> Color {
        var color = Color.init(hexcode: "")
        if resume.applyState == .waiting {
            color = Color.init(hexcode: "000000").opacity(0.87)
        } else if resume.applyState == .invited {
            color = ColorConstant.main.color()
        } else if resume.applyState == .rejected {
            color = Color.init(hexcode: "000000").opacity(0.38)
        }
        return color
    }
    
}

extension ResumeView {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Spacer()
                
                TextWithFont(text: "알고리즘 스터디원 구합니다", font: .regular, size: 16)
                    .foregroundColor(
                        Color.init(hexcode: "000000")
                            .opacity(0.87)
                    )
                
                TextWithFont(text: "1시간 전", font: .regular, size: 12)
                    .frame(height: 20)
                    .foregroundColor(
                        Color.init(hexcode: "000000")
                            .opacity(0.38)
                    )
                
                Spacer()
            }
            .padding(.vertical, 3)
            
            Spacer()
                        
            TextWithFont(text: applyStateTitle(), font: .bold, size: 15)
                .frame(width: 43, height: 26)
                .foregroundColor(applyStateColor())
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 13)        
        .frame(height: 70)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white)
                    .shadow(color: Color.init(hexcode: "000000").opacity(0.12), radius: 5, x: 0, y: 1)
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white)
                    .shadow(color: Color.init(hexcode: "000000").opacity(0.14), radius: 5, x: 0, y: 3)
            }
            )
        .padding(.bottom, 5)
        .padding(.horizontal, 10)
    }
    
}
