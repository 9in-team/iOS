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
        let urlType = UrlType.testDomain
        let endPoint = "teams"

        // when
        let expectation = XCTestExpectation(description: "데이터 가져오기")

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
            if !responseData.teams.isEmpty {
                expectation.fulfill()
            }
        })
        .store(in: &cancellables)

        wait(for: [expectation])

    }

    func testFetchTeamDetail() {
        // given
        let teamId = 0
        let headerType = HeaderType.test
        let urlType = UrlType.testDomain
        let endPoint = "teams"

        // when
        let expectation = XCTestExpectation(description: "ID값 받아서 Team Detail 가져오기")

        // then
        networkService.GET(headerType: .test,
                    urlType: .testDomain,
                    endPoint: "\(endPoint)/\(teamId)",
                    parameters: [:],
                    returnType: TeamDetail.self)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                print("GET 요청 실패: \(error)")
            case .finished:
                break
            }
        }, receiveValue: {  responseData in
            print("GET 요청 성공: \(responseData)")
            expectation.fulfill()
        })
        .store(in: &cancellables)

        wait(for: [expectation])

    }

}
