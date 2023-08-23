//
//  RoleAlert.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/08/10.
//

import SwiftUI

struct RoleAlert: View {
    
    @ObservedObject var viewModel: WritePostViewModel
    @Binding var showRoleAlert: Bool
    @State private var roleName: String = ""
    @State private var count: Int = 1

}

extension RoleAlert {
    
    var body: some View {
        BaseAlert(bottomPadding: 0) {
            mainBody()
                .padding()
        }
    }

    private func mainBody() -> some View {
        VStack(spacing: 16) {
            roleNameTextField()
            
            stepper()
            
            Spacer()
            
            actionButtons()
        }
    }
    
    private func stepper() -> some View {
        VStack {
            Text("\(count) 명")
                .font(.custom(.robotoMedium, size: 18))
            
            Stepper {
                EmptyView()
            } onIncrement: {
                count += 1
            } onDecrement: {
                if count > 1 {
                    count -= 1
                }
            }
            .labelsHidden()
        }
    }
    
    private func roleNameTextField() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.init(uiColor: .secondarySystemFill))
            
            TextField("모집대상을 입력하세요", text: $roleName)
                .padding(.horizontal)
                .cornerRadius(12)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .textCase(.none)
        }
        .frame(height: 42)
        .padding(.top)
    }
    
    private func actionButtons() -> some View {
        VStack {
            
            Button("확인") {
                if roleName.isEmpty {
                    viewModel.showToast(title: "모집할 역할을 입력해주세요.")
                    return
                }
                
                let role = Role(title: roleName, count: count)
                viewModel.roles.append(role)
                showRoleAlert = false
            }
            .buttonStyle(SubmitButtonStyle(.medium(color: .primary, font: .small)))
            
            Button("취소") {
                showRoleAlert = false
            }
            .buttonStyle(SubmitButtonStyle(.medium(color: .primary, font: .small)))
            
        }
    }
        
}

#if DEBUG
struct RoleAlert_Previews: PreviewProvider {
    static var previews: some View {
        RoleAlert(viewModel: WritePostViewModel(), showRoleAlert: .constant(true))
    }
}
#endif
