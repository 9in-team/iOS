//
//  MyPostViewModel.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/14.
//

import Foundation

class MyPostViewModel: BaseViewModel {
    
    var service: NetworkProtocol
    
    @Published var posts: [Post] = []
    
    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
    }
    
}
