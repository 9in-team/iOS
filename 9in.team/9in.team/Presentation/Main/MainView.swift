//
//  MainView.swift
//  9in.team
//
//  Created by 조상현 on 2023/02/06.
//

import SwiftUI

struct MainView: View {
    
}

extension MainView {
    
    var body: some View {
        NavigationView {
            BaseView {
                Text("9in.team")
            }
            .showNavigationBar(NavigationBar(useDismissButton: false, title: "9in.team"))
        }
    }
    
}
