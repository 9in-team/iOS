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

    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
    }
    
    func requestFristPage() {
        requestTeams()
    }

    func requestDetailPage(teamId: Int) {
        requestTeamDetail(teamId: teamId)
    }

    func write(accountId: Int, content: PostWriteTeam) {
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

    private func postWriteTeam(accountId: Int, content: PostWriteTeam, completion: () -> Void) {
        service.POST(headerType: .test,
                     urlType: .testDomain,
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
    let roles: [RecruitmentRole]
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
    let roles: [RecruitmentRole]
}

//{
//    "detail": {
//        "teamId": 2,
//        "openChatUrl": "http://9in-proejct.chat",
//        "content": "열심히 할 사람 구함",
//        "subject": "스프링 프젝 구함",
//        "teamTemplates": [
//            {
//                "type": "TEXT",
//                "question": "의지를 말해보아라",
//                "options": null
//            },
//            {
//                "type": "CHECKBOX",
//                "question": "열심히 할거니",
//                "options": "네, 아니"
//            }
//        ],
//        "types": [
//            "KOTLIN",
//            "JAVA",
//            "MYSQL"
//        ],
//        "subjectType": "PROJECT",
//        "roles": [
//            {
//                "name": "프론트엔드",
//                "requiredCount": 2,
//                "hiredCount": 0
//            },
//            {
//                "name": "백엔드",
//                "requiredCount": 3,
//                "hiredCount": 0
//            }
//        ]
//    },
//    "errorMessage": null
// }


//
//{
//    {
//    "subjectType" : "PROJECT",
//    "subject" : "스프링 프젝 구함",
//    "types" : ["KOTLIN","JAVA", "MYSQL"],
//    "roles" : [
//        {"name" : "프론트엔드", "requiredCount" : 2},
//        {"name" : "백엔드", "requiredCount" : 3}
//    ],
//    "content" : "열심히 할 사람 구함",
//    "teamTemplates" : [
//        {"type" : "TEXT","question" : "의지를 말해보아라"},
//        {"type" : "CHECKBOX", "question" : "열심히 할거니", "options" : "네, 아니"}
//    ],
//    "openChatUrl" : "http://9in-proejct.chat"
//}
//
//}
