//
//  SubscribeHashTagView.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/04/20.
//

import SwiftUI

struct SubscribeHashTagView: View {

    let navigationTitle = "구독하기"

    @State var currentTab: Int = 0 {
        willSet {
            viewModel.getHashTags(withType: newValue == 0 ? .study : .project)
        }
    }

    @ObservedObject var viewModel = SubscribeHashTagViewModel()

}

extension SubscribeHashTagView {

    var body: some View {
        BaseView(appState: viewModel.appState) {
            mainBody()
                .onAppear {
                    viewModel.getHashTags(withType: self.currentTab == 0 ? .study : .project)
                }
                .onDisappear {
                    viewModel.cancel()
                }
        }
        .showTabNavigationBar(NavigationBar(useDismissButton: true, title: navigationTitle),
                              TabNavigationBar(tabList: ["스터디", "프로젝트"]) { selectedIndex in
            currentTab = selectedIndex
        })
    }

    func mainBody() -> some View {
        VStack(spacing: 16) {
            // TODO: 리스트 받으면 바로 표시되도록 하기
                ForEach(viewModel.hashtags, id: \.self) { tag in
                    SubscribeHashTagCell(title: tag.name,
                                         count: tag.count,
                                         subscribing: tag.subscribing ?? false)
                }
                
                Spacer()
        }
        .padding(.horizontal, 20)

    }

}

struct SubscribeTagView_Previews: PreviewProvider {
    static var previews: some View {
        SubscribeHashTagView()
    }
}
