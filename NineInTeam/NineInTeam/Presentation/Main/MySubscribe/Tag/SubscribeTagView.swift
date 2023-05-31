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
            ForEach(viewModel.hashtags, id: \.self) { tag in
                SubscribeTagCell(title: tag.name, count: tag.count, subscribing: tag.subscribing ?? false)
            }

            Spacer()
        }
        .padding(.horizontal, 20)
        .onAppear {
            viewModel.getHashTag()
        }
    }

}

struct SubscribeTagView_Previews: PreviewProvider {
    static var previews: some View {
        SubscribeTagView()
    }
}
