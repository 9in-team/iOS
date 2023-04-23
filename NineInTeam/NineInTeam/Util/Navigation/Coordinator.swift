//
//  Coordinator.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/04/15.
//

import SwiftUI
import Combine

final class Coordinator: ObservableObject {
     
    private var destination: Destination = .signIn
    
    @Published private var rootNavigationTrigger = false
    @Published private var navigationTrigger = false
    
    private let isRoot: Bool
    private let kPopToRoot = Notification.Name("popToRoot")
    
    private var cancellable: Set<AnyCancellable> = []
    
    init(isRoot: Bool = false) {
        self.isRoot = isRoot
        
        if isRoot {
            NotificationCenter.default.publisher(for: kPopToRoot)
                .sink { [unowned self] _ in
                    rootNavigationTrigger = false
                }
                .store(in: &cancellable)
        }
    }
    
    @ViewBuilder
    func navigationLinkSection() -> some View {
        NavigationLink(isActive: Binding<Bool>(get: getTrigger, set: setTrigger(newValue:))) {
            destination.view
        } label: {
            EmptyView()
        }
    }
    
    func popToRoot() {
        NotificationCenter.default.post(name: kPopToRoot, object: nil)
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
    
}
