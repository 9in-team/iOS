//
//  KakaoAuthTests.swift
//  NineInTeamTests
//
//  Created by HeonJin Ha on 2023/06/18.
//

import XCTest
import Combine
@testable import NineInTeam

final class KakaoAuthTests: XCTestCase {

    var sut: NetworkService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        sut = .init()
        cancellables = .init()
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        cancellables = nil
        sut = nil
    }
    
    func test_logout() {
        // given
        
        // when
        
        //then
    }
    
    func test_login() {
        // given
        let token = ""
        let
        
        // when
        
        // then
        
    }
    
    // 모집 글 리스트(홈)
    func test_fetch_homeView_list() {
        // given
        let headerType = HeaderType.test
        let urlType = UrlType.testDomain
        let endPoint = "teams"

        // when
        let expectation = XCTestExpectation(description: "GET Request Result가 SUCCESS 입니다.")

        // then
        sut.GET(headerType: headerType,
                    urlType: urlType,
                    endPoint: endPoint,
                    parameters: [:],
                    returnType: TeamResponse.self)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                XCTFail("요청 실패 \(error.localizedDescription)")
            case .finished:
                break
            }
        }, receiveValue: { responseData in
            XCTAssertEqual(responseData.result, "SUCCESS", "result가 SUCCESS인지 확인합니다.")
            XCTAssertFalse(responseData.teams.isEmpty, "teams가 비어있는지 확인합니다.")
            expectation.fulfill()
        })
        .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)

    }

    // 모집 글 상세
    func test_fetch_team_detail() {
        // given
        let teamId = 0
        let headerType = HeaderType.test
        let urlType = UrlType.testDomain
        let endPoint = "teams"

        // when
        let expectation = XCTestExpectation(description: "ID값 받아서 Team Detail 가져오기")

        // then
        sut.GET(headerType: headerType,
                    urlType: urlType,
                    endPoint: "\(endPoint)/\(teamId)",
                    parameters: [:],
                    returnType: TeamDetail.self)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                XCTFail("Request faileure: \(error.localizedDescription)")
            case .finished:
                break
            }
        }, receiveValue: {  responseData in
            XCTAssertEqual(responseData.result, "SUCCESS", "result가 SUCCESS인지 확인합니다.")
            expectation.fulfill()
        })
        .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)

    }

}
