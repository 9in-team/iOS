//
//  ReceivedPostView.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/04/16.
//

import SwiftUI

struct ReceivedPostView: View {

    private let navigationTitle = "받은 지원서"

    @ObservedObject private var viewModel = ReceivedPostViewModel()

}

extension ReceivedPostView {

    var body: some View {

        BaseView(appState: viewModel.appState) {
            mainBody()
                .environmentObject(viewModel)
        }
        .showNavigationBar(NavigationBar(useDismissButton: true, title: navigationTitle))
        .ignoresSafeArea(edges: [.bottom, .horizontal])

    }

    func mainBody() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 13) {

                TextWithFont(text: "알고리즘 스터디원 구합니다", font: .regular, size: 24)

                VStack(alignment: .leading, spacing: 35) { // 추후 List로 바꿀예정
                    ReceivedPostCell(message: "", isApproved: false)

                    ReceivedPostCell(approvalStatus: .apply,
                                     message: "저희 같이 스터디 잘 해봐요 :) 전달된 채팅방 링크 통해서 들어와주세요!",
                                     isApproved: false)

                    ReceivedPostCell(approvalStatus: .apply,
                                     message: "저희 같이 스터디 잘 해봐요 :) 전달된 채팅방 링크 통해서 들어와주세요!",
                                     isApproved: true)

                    ReceivedPostCell(approvalStatus: .deny,
                                     isApproved: true)
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
}
