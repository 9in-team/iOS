//
//  HomeViewModel.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/07.
//

import Foundation
import Combine

class HomeViewModel: BaseViewModel {
    
    private var service: NetworkProtocol
    
    @Published var teams: [Team] = []
    @Published var teamDetail: TeamDetail?
    @Published var content: String = ""
    @Published var subject: String = ""
    @Published var openChatUrl: String = ""
    @Published var hashtags: [HashTag] = []
    @Published var subjectType: SubjectType = .project
    @Published var roles: [Role] = []
    @Published var templates: [TeamTemplate] = []
    
    @Published var roleTitle: String = ""
    @Published var roleCount: Int = 1
    @Published var question: String = ""

    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
        super.init()
    }
    
    func requestFristPage() {
        requestTeams()
    }

    func requestDetailPage(teamId: Int) {
        requestTeamDetail(teamId: teamId)
    }

    func write(accountId: Int, content: Team) {
        postWriteTeam(accountId: accountId, content: content) {

        }
    }

    private func requestTeams() {
        service.GET(headerType: .test,
                    urlType: .testDomain,
                    endPoint: "teams",
                    parameters: [:],
                    returnType: TeamResponse.self)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                print("GET 요청 실패: \(error)")
            case .finished:
                break
            }
        }, receiveValue: { [weak self] responseData in
            self?.teams = responseData.teams
            print("GET 요청 성공: \(responseData)")
        })
        .store(in: &cancellables)
    }

    private func requestTeamDetail(teamId: Int) {
        service.GET(headerType: .test,
                    urlType: .testDomain,
                    endPoint: "teams/\(teamId)",
                    parameters: [:],
                    returnType: TeamDetail.self)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                print("GET 요청 실패: \(error)")
            case .finished:
                break
            }
        }, receiveValue: { [weak self] responseData in
            self?.teamDetail = responseData
            print("GET 요청 성공: \(responseData)")
        })
        .store(in: &cancellables)
    }

    private func postWriteTeam(accountId: Int, content: Team, completion: () -> Void) {
        service.POST(headerType: .test,
                     urlType: .testDomain,
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

// struct PostWriteTeam: Decodable {
//     let subjectType: String
//     let subject: String
//     let types: [String]
//     let roles: [RecruitmentRole]
//     let content: String
//     let teamTemplates: [TeamTemplate]
//     let openChatUrl: String
// }
//
struct ResultWriteTeam: Decodable {
    let detail: Team
    let errorMessage: String?
}
//
// struct DetailWriteTeam: Decodable {
//     let teamId: Int
//     let openChatUrl: String
//     let content: String
//     let teamTemplates: [TeamTemplate]
//     let types: [String]
//     let subjectType: String
//     let roles: [Role]
// }
