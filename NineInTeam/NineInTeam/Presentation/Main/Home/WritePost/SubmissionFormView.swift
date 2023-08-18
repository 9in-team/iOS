//
//  TeamTemplateForm.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/07/30.
//

import SwiftUI

struct SubmissionFormView: View {
    
    let form: SubmissionForm
    
    @State var question: String = ""
    
    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color(hexcode: "000000")
                        .opacity(0.23)
                    )
                    .frame(width: 62, height: 62)
                    .overlay(
                        TextWithFont(text: "\(form.number ?? 0)", font: .robotoMedium, size: 12)
                            .foregroundColor(Color(hexcode: "FFFFFF"))
                            .padding(6)
                            .background(ColorConstant.main.color())
                            .clipShape(Circle())
                            .offset(x: -31, y: -31)
                    )
                
                VStack(spacing: 5) {
                    Image(form.type.asset())
                        .resizable()
                        .frame(width: form.type.assetSize().width, height: form.type.assetSize().height)
                        .padding(.top, 3)
                    
                    TextWithFont(text: form.type.text(), size: 12)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                TextField("양식에 대한 설명을 입력해주세요.", text: $question)
                    .font(.custom(.robotoMedium, size: 16))
                    .foregroundColor(
                        Color(hexcode: "000000")
                            .opacity(0.6)
                    )
                          
                Divider()
                    .frame(height: 1)
                    .foregroundColor(
                        Color(hexcode: "000000")
                            .opacity(0.42)
                    )
                    .border(Color(hexcode: "000000").opacity(0.42),
                            width: 1)
            }
        }
    }
}

#if DEBUG
struct TeamTemplateForm_Previews: PreviewProvider {
    
    static let teamTemplate = SubmissionForm(type: .checkBox, question: "화이팅 하실건가요?")
    
    static var previews: some View {
        SubmissionFormView(form: teamTemplate, question: teamTemplate.question)
    }
}
#endif
