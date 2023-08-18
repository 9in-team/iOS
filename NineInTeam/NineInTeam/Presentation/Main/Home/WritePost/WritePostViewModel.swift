//
//  WritePostViewModel.swift
//  NineInTeam
//
//  Created by HeonJin Ha on 2023/08/10.
//

import Foundation

final class WritePostViewModel: BaseViewModel {
    
    private var service: NetworkProtocol
    
    let allTag = ["Python", "Spring Framework", "AWS", "iOS", "HTML", "Java", "JavaScript", "C#", "C++", "JPA", "React", "Node", "Vue", "MySQL", "Kotlin", "Android", "SQL"]
    
    @Published var content: String = ""
    @Published var subject: String = ""
    @Published var openChatUrl: String = ""
    @Published var hashtags: [HashTag] = []
    @Published var subjectType: SubjectType = .project
    @Published var templates: [SubmissionForm] = []
    @Published var roles: [Role] = []
    
    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
        super.init()
    }
    
}

extension WritePostViewModel {
    
    func submit() {
        do {
            try checkInputData()
        } catch {
            return
        }

        if let id = AuthManager.shared.userData?.id {
            let randomTeamId = Int.random(in: 1...1000000) // Post API 사용가능하게 될 시 부여 규칙 가져와서 수정
            let team = Team(teamId: randomTeamId,
                            subject: subject,
                            openChatUrl: openChatUrl,
                            templates: templates,
                            hashtags: hashtags,
                            type: subjectType,
                            requiredRoles: roles)
            
            submitTeam(accountId: id, teamId: randomTeamId, content: team) {
                // Post API 사용가능하게 될 시 작성
            }
        }
    }
    
    private func checkInputData() throws {
        if subject.isEmpty {
            showToast(title: "제목을 입력해주세요.")
            throw WritePostError.invalidInputData
        }
        
        if templates.isEmpty {
            showToast(title: "지원 양식을 추가해 주세요.")
            throw WritePostError.invalidInputData
        }
        
        if hashtags.isEmpty {
            showToast(title: "태그를 추가해 주세요.")
            throw WritePostError.invalidInputData
        }
        
        if roles.isEmpty {
            showToast(title: "모집 역할을 추가해주세요.")
            throw WritePostError.invalidInputData
        }
    }
    
    private func submitTeam(accountId: Int,
                            teamId: Int,
                            content: Team,
                            completion: @escaping() -> Void) {
        
        service.POST(headerType: .test,
                     urlType: .test9inTeam,
                     endPoint: EndPoint.POST.writeTeam(teamId).urlString(),
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
