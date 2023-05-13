//
//  MySubscribeViewModel.swift
//  9in.team
//
//  Created by 조상현 on 2023/03/14.
//

import Foundation

class MySubscribeViewModel: BaseViewModel {
    
    var service: NetworkProtocol
    
    @Published var subscribes: [Subscribe] = [
        Subscribe(),
        Subscribe(),
        Subscribe(),
        Subscribe()
    ]
    
    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
    }
    
}
