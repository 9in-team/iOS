//
//  ChatDetailViewModel.swift
//  9in.team
//
//  Created by Heonjin Ha on 2023/04/04.
//

import SwiftUI

class ChatDetailViewModel: BaseViewModel {
    
    var service: NetworkProtocol
    
    // 임시 변수
    let userId: String = "admin456"
    
    @Published var chats: [Chat] = []
    
    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
    }
    
    func getChatDetail(chatId: Int) {
        service.GET(headerType: .test,
                     urlType: .testLocal2,
                     endPoint: "chats/\(chatId)",
                     parameters: [:],
                     returnType: ChatResponse.self)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                print("GET 요청 실패: \(error)")
            case .finished:
                break
            }
        }, receiveValue: { [weak self] responseData in
            self?.chats = responseData.chats
            print("GET 요청 성공: \(responseData)")
        })
        .store(in: &cancellables)
    }
    
}
