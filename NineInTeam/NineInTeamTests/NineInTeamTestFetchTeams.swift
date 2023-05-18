//
//  NineInTeamTestFetchTeams.swift
//  NineInTeamTests
//
//  Created by Heonjin Ha on 2023/05/17.
//

import XCTest
import Combine
@testable import NineInTeam

final class NineInTeamTestFetchTeams: XCTestCase {

    private var networkService: NetworkService!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        networkService = .init()
        cancellables = .init()
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        networkService = nil
        cancellables = nil
    }

    func testFetchTeams() {
        // given
        let headerType = HeaderType.test
        let urlType = UrlType.testLocal
        let endPoint = "teams"

        // when
        let expectation = XCTestExpectation(description: "가져오기 성공")

        // then
        networkService.GET(headerType: headerType,
                    urlType: urlType,
                    endPoint: endPoint,
                    parameters: [:],
                    returnType: TeamResponse.self)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                print("GET 요청 실패: \(error)")
            case .finished:
                break
            }
        }, receiveValue: { responseData in
            expectation.fulfill()
        })
        .store(in: &cancellables)

    }
}
