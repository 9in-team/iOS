//
//  SubmitResumeViewModel.swift
//  NineInTeam
//
//  Created by 조상현 on 2023/07/19.
//

import Foundation
import Combine
import UIKit

class SubmitResumeViewModel: BaseViewModel {
    
    private var service: NetworkProtocol
    
    @Published var teamDetail: TeamDetail?
    
    @Published var answerText: String = ""
    @Published var answerImage: UIImage? = nil
    @Published var answerFileList: [URL] = []
    @Published var answerChoice: String = ""
    
    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
    }
    
}
