//
//  MyResumeViewModel.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/14.
//

import Foundation

class MyResumeViewModel: BaseViewModel {
    
    var service: NetworkProtocol
    
    @Published var teams: [Team] = []
    
    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
    }
    
}
