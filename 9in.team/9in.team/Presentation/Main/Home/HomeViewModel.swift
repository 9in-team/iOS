//
//  HomeViewModel.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/07.
//

import Foundation

class HomeViewModel: BaseViewModel {
    
    var service: NetworkProtocol
    
    @Published var teams: [Team] = []
    
    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
    }
    
    func requestFristPage() {
        if teams.isEmpty {
            requestTeams()
        }
    }
        
    func requestTeams() {
        teams.append(Team(teamId: 0,
                          subject: "알고리즘 스터디원 구합니다",
                          leader: "김진홍",
                          hashtags: ["#알고리즘", "#Java"],
                          lastModified: "1시간 전"))
        
        teams.append(Team(teamId: 1,
                          subject: "알고리즘 스터디원 구합니다",
                          leader: "조상현",
                          hashtags: ["#알고리즘", "#Swift"],
                          lastModified: "1시간 전"))
    }
    
}
