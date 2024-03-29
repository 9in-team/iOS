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
    case submitResume(TeamDetail)

    case mySubscribe
    case subscribeTag
    case myWish

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
        case .submitResume(let teamDetail):
            SubmitResumeView(teamDetail: teamDetail)
        case .mySubscribe:
            MySubscribeView()
        case .subscribeTag:
            SubscribeTagView()
        case .myWish:
            MyWishView()
        case .myPost:
            MyPostView()
        case .postDetail:
            PostDetailView()
        case .myResume:
            MyResumeView()
        }
    }

}
