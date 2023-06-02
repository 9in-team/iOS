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

    @Published var studyHashtags: [SubscribeHashtag] = []
    @Published var projectHashtags: [SubscribeHashtag] = []

    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
        super.init()
    }

}

extension SubscribeHashTagViewModel {

// TODO: study, project로 나누기
  func getHashTag() {
        service.GET(headerType: .test,
                    urlType: .testLocal,
                    endPoint: "hashtags",
                    parameters: [:],
                    returnType: SubscribeHashtagList.self)
        .map { $0.list }
        .sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
            }
        } receiveValue: { [unowned self] tags in
            self.studyHashtags = tags.filter { $0.type.rawValue == HashTagType.study.rawValue }
            self.projectHashtags = tags.filter { $0.type.rawValue == HashTagType.project.rawValue }
        }
        .store(in: &cancellables)
    }

    func filterTag(tag: HashTagType) {

    }
    
}

