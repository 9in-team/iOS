//
//  Destination.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/04/22.
//

import SwiftUI

enum Destination {

    case signIn
    case main

    case profileEdit
    case chatList

    case home
    case teamDetail(Int)
    case writePost

    case mySubscribe

    case myPost
    case postDetail

    case myResume

    @ViewBuilder
    var view: some View {
        switch self {
        case .signIn:
            SignInView()
        case .main:
            MainView()
        case .profileEdit:
            ProfileEditView()
        case .chatList:
            ChatListView()
        case .home:
            HomeView()
        case .teamDetail(let teamId):
            TeamDetailView(teamId: teamId)
        case .writePost:
            WritePostView()
        case .mySubscribe:
            MySubscribeView()
        case .myPost:
            MyPostView()
        case .postDetail:
            PostDetailView()
        case .myResume:
            MyResumeView()
        }
    }

}
