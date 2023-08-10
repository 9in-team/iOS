//
//  WritePostViewModel.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/08/10.
//

import Foundation

final class WritePostViewModel: BaseViewModel {
    
    private var service: NetworkProtocol
    
    let allTags = ["Python", "Spring Framework", "AWS", "iOS", "HTML", "Java", "JavaScript", "C#", "C++", "JPA", "React", "Node", "Vue", "MySQL", "Kotlin", "Android", "SQL"]
    
    @Published var content: String = ""
    @Published var subject: String = ""
    @Published var openChatUrl: String = ""
    @Published var hashtags: [HashTag] = []
    @Published var subjectType: SubjectType = .project
    @Published var templates: [TeamTemplate] = []
    
    @Published var roles: [Role] = []
    
    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
        super.init()
    }
    
}

extension WritePostViewModel {
    
    func write() {
        if subject.isEmpty {
            showToast(title: "제목을 입력해주세요.")
            return
        }
        
        if templates.isEmpty {
            showToast(title: "지원 양식을 추가해 주세요.")
            return
        }
        
        if hashtags.isEmpty {
            showToast(title: "태그를 추가해 주세요.")
            return
        }
        if roles.isEmpty {
            showToast(title: "모집 역할을 추가해주세요.")
            return
        }

        if let id = AuthManager.shared.userData?.id {
            let randomTeamId = Int.random(in: 1..<1000000)
            let team = Team(teamId: randomTeamId,
                            subject: subject,
                            openChatUrl: openChatUrl,
                            templates: templates,
                            hashtags: hashtags,
                            type: subjectType,
                            requiredRoles: roles)
            postWriteTeam(accountId: id, content: team) {
                
            }
        }
    }
    
    private func postWriteTeam(accountId: Int, content: Team, completion: @escaping() -> Void) {
        service.POST(headerType: .test,
                     urlType: .test9inTeam,
                     endPoint: "team/\(accountId)",
                     parameters: [:],
                     returnType: Team.self)
        .sink { result in
            print(result)
        } receiveValue: { responseData in
            print(responseData)
        }
        .store(in: &cancellables)
    }
    
}
