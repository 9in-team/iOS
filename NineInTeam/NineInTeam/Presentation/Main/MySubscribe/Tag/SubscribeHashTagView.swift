//
//  SubscribeHashTagView.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/04/20.
//

import SwiftUI

struct SubscribeHashTagView: View {

    let navigationTitle = "구독하기"

    @State var currentTab: Int = 0

    @ObservedObject var viewModel = SubscribeHashTagViewModel()

}

extension SubscribeHashTagView {

    // TODO: 스터디 / 프로젝트 누르면 그것에 따른 태그 변경
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
            if currentTab == 0 {
                ForEach(viewModel.studyHashtags, id: \.self) { tag in
                    SubscribeTagCell(title: tag.name, count: tag.count, subscribing: tag.subscribing ?? false)
                }
            } else {
                ForEach(viewModel.projectHashtags, id: \.self) { tag in
                    SubscribeTagCell(title: tag.name, count: tag.count, subscribing: tag.subscribing ?? false)
                }
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
        SubscribeHashTagView()
    }
}
