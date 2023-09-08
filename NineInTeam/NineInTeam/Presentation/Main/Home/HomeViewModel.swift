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
    
}
