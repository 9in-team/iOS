//
//  SubscribeTagView.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/04/20.
//

import SwiftUI

struct SubscribeTagView: View {
    
    let navigationTitle = "구독하기"
    
    @State var currentTab: Int = 0
    
    @ObservedObject var viewModel = SubscribeTagViewModel()
    
}

extension SubscribeTagView {
    
    var body: some View {
        BaseView(appState: viewModel.appState) {
            mainBody()
        }
        .showTabNavigationBar(NavigationBar(useDismissButton: true, title: navigationTitle),
                              TabNavigationBar(tabList: ["스터디", "프로젝트"]) { selectedIndex in
            currentTab = selectedIndex
        })
    }
    
    func mainBody() -> some View {
        VStack(spacing: 16) {
            SubscribeTagCell(isSubscribe: .constant(false))
            
            SubscribeTagCell(isSubscribe: .constant(true))
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
}

struct SubscribeTagView_Previews: PreviewProvider {
    static var previews: some View {
        SubscribeTagView()
    }
}
