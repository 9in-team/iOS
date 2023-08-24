//
//  TeamTemplateForm.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/07/30.
//

import SwiftUI

struct SubmissionFormView: View {
    
    private let form: SubmissionForm
    private let editMode: Bool
    private var deleteAction: (() -> Void)?
    
    @State var question: String
    
    init(form: SubmissionForm, 
         question: String = "",
         editMode: Bool = false,
         deleteAction: (() -> Void)? = nil
    ) {
        self.form = form
        self.question = question
        self.editMode = editMode
        self.deleteAction = deleteAction
    }
    
}

extension SubmissionFormView {
    
    var body: some View {
        HStack(spacing: 8) {
            checkBox()
            
            inputContainer()
            
            if editMode {
                deleteButton()
            }
        }
        .disabled(!editMode)
    }
    
    private func deleteButton() -> some View {
        Button {
            if let deleteAction = deleteAction {
                deleteAction()
            }
        } label: {
            ZStack {
                Image("Xmark")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(ColorConstant.gray.color())
                    .padding(4)
            }
        }
        .frame(width: 24, height: 24)
    }
    
    private func inputContainer() -> some View {
        let textColor = editMode
        ? ColorConstant.gray.color()
        : ColorConstant.lightGray.color()
        
        return VStack(alignment: .leading, spacing: 8) {
            TextField("양식에 대한 설명을 입력해주세요.", text: $question)
                .font(.custom(.robotoMedium, size: 16))
                .foregroundColor(textColor)
            
            bottomLine()
        }
    }
    
    private func bottomLine() -> some View {
        let color = Color(hexcode: "000000").opacity(0.42)
        
        return Divider()
            .frame(height: 1)
            .foregroundColor(
                Color(hexcode: "000000")
                    .opacity(0.42)
            ).border(color, width: 1)
    }
    
    private func checkBox() -> some View {
        ZStack {
            checkBoxBackground()
            
            VStack(spacing: 5) {
                Image(form.type.asset())
                    .resizable()
                    .frame(width: form.type.assetSize().width, height: form.type.assetSize().height)
                    .padding(.top, 3)
                
                TextWithFont(text: form.type.text(), size: 12)
            }
        }
    }
    
    private func checkBoxBackground() -> some View {
        RoundedRectangle(cornerRadius: 4)
            .stroke(Color(hexcode: "000000")
                .opacity(0.23)
            )
            .frame(width: 62, height: 62)
            .overlay(
                TextWithFont(text: "\(form.number ?? 0)", font: .robotoMedium, size: 12)
                    .foregroundColor(Color(hexcode: "FFFFFF"))
                    .padding(6)
                    .background(ColorConstant.primary.color())
                    .clipShape(Circle())
                    .offset(x: -31, y: -31)
            )
    }
}

#if DEBUG
struct TeamTemplateForm_Previews: PreviewProvider {
    
    static let teamTemplate = SubmissionForm(type: .checkBox, question: "화이팅 하실건가요?")
    
    static var previews: some View {
        
        VStack {
            SubmissionFormView(form: teamTemplate, question: teamTemplate.question, editMode: true, deleteAction: nil)
            
            SubmissionFormView(form: teamTemplate, question: teamTemplate.question)
        }
        
    }
}
#endif
