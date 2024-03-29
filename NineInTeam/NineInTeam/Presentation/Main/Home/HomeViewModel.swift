//
//  HomeViewModel.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/07.
//

import Foundation
import Combine

final class HomeViewModel: BaseViewModel {
    
    private var service: NetworkProtocol
        
    @Published var teams: [Team] = []
    @Published var teamDetail: TeamDetail?

    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
        super.init()
    }
    
    func requestFristPage() {
        requestTeams()
    }

    private func requestTeams() {
        service.GET(headerType: .test,
                    urlType: .testServer,
                    endPoint: "team",
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
                    urlType: .testServer,
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

    private func postWriteTeam(accountId: Int, content: PostWriteTeam, completion: () -> Void) {
        service.POST(headerType: .test,
                     urlType: .testServer,
                     endPoint: "team/\(accountId)",
                     parameters: [:],
                     returnType: ResultWriteTeam.self)
        .sink { result in
            print(result)
        } receiveValue: { responseData in
            if let error = responseData.errorMessage {
                print(error)
                return
            }
        }
        .store(in: &cancellables)
    }
}

struct PostWriteTeam: Decodable {
    let subjectType: String
    let subject: String
    let types: [String]
    let roles: [Role]
    let content: String
    let teamTemplates: [SubmissionForm]
    let openChatUrl: String
}

struct ResultWriteTeam: Decodable {
    let detail: DetailWriteTeam
    let errorMessage: String?
}

struct DetailWriteTeam: Decodable {
    let teamId: Int
    let openChatUrl: String
    let content: String
    let teamTemplates: [SubmissionForm]
    let types: [String]
    let subjectType: String
    let roles: [Role]
}

