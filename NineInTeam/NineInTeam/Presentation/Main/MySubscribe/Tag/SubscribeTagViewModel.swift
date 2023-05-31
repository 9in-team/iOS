//
//  SubscribeTagViewModel.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/04/20.
//

import SwiftUI

final class SubscribeTagViewModel: BaseViewModel {

    private var service: NetworkProtocol

    @Published var hashtags: [Hashtag] = []

    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
        super.init()
    }

}

extension SubscribeTagViewModel {

  func getHashTag() {
        service.GET(headerType: .test,
                    urlType: .testLocal,
                    endPoint: "hashtags",
                    parameters: [:],
                    returnType: HashtagResponse.self)
        .sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
            }
        } receiveValue: { [unowned self] tags in
            self.hashtags = tags.list
        }
        .store(in: &cancellables)
    }
}
