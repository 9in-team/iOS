//
//  RadioButtonGroups.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/21.
//

import SwiftUI

struct RadioButtonGroups: View {
    
    let items: [String]
    var scrollable: Bool = false
    let completion: (Int) -> Void
    
    @State var selectedIndex: Int = 0
    
    var body: some View {
        if scrollable {
            ScrollView(.horizontal, showsIndicators: false) {
                radioButtons
            }
        } else {
            HStack {
                radioButtons
                
                Spacer()
            }
        }
    }
    
    var radioButtons: some View {
        ForEach(Array(zip(items.indices, items)), id: \.0) { index, title in
            RadioButtonField(index: index, title: title, isChecked: selectedIndex == index) {
                selectedIndex = index
                completion(selectedIndex)
            }
        }
    }
    
}
