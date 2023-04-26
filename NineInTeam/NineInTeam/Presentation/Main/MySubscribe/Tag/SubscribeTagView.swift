//
//  SubscribeTagView.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/04/20.
//

import SwiftUI

struct SubscribeTagView: View {

    let navigationTitle = "구독하기"

    @ObservedObject var viewModel = SubscribeTagViewModel()
}

extension SubscribeTagView {

    var body: some View {
        BaseView(appState: viewModel.appState) {
            mainBody()
        }
        .showNavigationBar(NavigationBar(useDismissButton: true, title: navigationTitle))
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
