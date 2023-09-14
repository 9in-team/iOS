//
//  ChatListViewModel.swift
//  9in.team
//
//  Created by 조상현 on 2023/04/02.
//

import Foundation

class ChatListViewModel: BaseViewModel {
    
    var service: NetworkProtocol
    
    @Published var chatRooms: [ChatRoom] = []
    
    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
    }
    
    // userId? 값이 필요하지 않나?
    func getChatRoom() {
        service.GET(headerType: .test,
                     urlType: .testServer,
                     endPoint: "chats",
                     parameters: [:],
                     returnType: ChatRoomResponse.self)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                print("GET 요청 실패: \(error)")
            case .finished:
                break
            }
        }, receiveValue: { [weak self] responseData in
            self?.chatRooms = responseData.chatRooms
            print("GET 요청 성공: \(responseData)")
        })
        .store(in: &cancellables)
    }
    
}
