//
//  Coordinator.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/04/15.
//

import SwiftUI

final class Coordinator: ObservableObject {
    
    var destination: Destination = .signIn

    @Published private var rootNavigationTrigger = false
    @Published private var navigationTrigger = false
    
    private let isRoot: Bool
    
    init(isRoot: Bool = false) {
        self.isRoot = isRoot
    }
    
    enum Destination {
        case signIn
        case main
        
        case home
        case teamDetail(Team)
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
            case .home:
                HomeView()
            case .teamDetail(let team):
                TeamDetailView(team: team)
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
    
    @ViewBuilder
    func navigationLinkSection() -> some View {
        // availableNavigation
        NavigationLink(isActive: Binding<Bool>(get: getTrigger, set: setTrigger(newValue:))) {
            destination.view
        } label: {
            EmptyView()
        }
    }

    func push(destination: Destination) {
        self.destination = destination
        if isRoot {
            rootNavigationTrigger.toggle()
        } else {
            navigationTrigger.toggle()
        }
    }
    
    private func getTrigger() -> Bool {
        isRoot ? rootNavigationTrigger : navigationTrigger
    }
      
    private func setTrigger(newValue: Bool) {
        if isRoot {
            rootNavigationTrigger = newValue
        } else {
            navigationTrigger = newValue
        }
    }
    
    func popToRoot() {
        NotificationCenter.default.post(name: Notification.Name("PopToRoot"), object: nil)
    }
    
}
