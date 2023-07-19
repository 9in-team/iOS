//
//  SubmitResumeViewModel.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/07/19.
//

import Foundation
import Combine

class SubmitResumeViewModel: BaseViewModel {
    
    private var service: NetworkProtocol
    
    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
    }
    
}
