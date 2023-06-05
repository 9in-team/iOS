//
//  SubscribeHashTagViewModel.swift
//  NineInTeam
//
//  Created by Heonjin Ha on 2023/04/20.
//

import SwiftUI
import Combine

final class SubscribeHashTagViewModel: BaseViewModel {

    private var service: NetworkProtocol

    private var allHashtagData = [Hashtag]()
    @Published var hashtags = [Hashtag]()

    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
        super.init()
    }

}

extension SubscribeHashTagViewModel {

    func cancel() {
        self.cancellables = Set<AnyCancellable>()
    }

    func getHashTags(withType: SubjectType) {
        getHashTag(type: withType)
    }

    private func getHashTag(type: SubjectType) {
        service.GET(headerType: .test,
                    urlType: .testDomain,
                    endPoint: "hashtags",
                    parameters: [:],
                    returnType: SubscribeHashtagList.self)
        .map { $0.list.filter { $0.type == type } }
        .sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
            }
        } receiveValue: { [unowned self] tags in
            self.hashtags = tags
        }
        .store(in: &cancellables)
    }

}

public enum NetworkingModelViewState {
    case loading
    case hasData
    case noResults
    case error
}
