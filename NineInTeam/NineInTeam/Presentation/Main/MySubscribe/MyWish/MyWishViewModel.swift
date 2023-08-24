//
//  MyWishViewModel.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/06/21.
//

import Foundation
import Combine

class MyWishViewModel: BaseViewModel {
    
    private var service: NetworkProtocol
    
    @Published var myWishList: [Team] = []
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

    private func requestTeams() {
        service.GET(headerType: .test,
                    urlType: .testServer,
                    endPoint: "myWishTeam",
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
            self?.myWishList = responseData.teams
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
    
}
