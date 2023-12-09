//
//  CheckboxButtonGroups.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/21.
//

import SwiftUI

struct CheckboxButtonGroups: View {
    
    @Binding private var selectedType: SubjectType

    init(_ type: Binding<SubjectType>) {
        self._selectedType = type
    }
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack {
                ForEach(SubjectType.allCases.indices) { index in
                    let type = SubjectType(rawValue: index) ?? .project
                    RadioButtonField(index: index, title: type.title, isChecked: type == selectedType) {
                        selectedType = type
                    }
                }
            }
      
            Spacer()
        }
    }
    
}
