//
//  FetchHashtagsTests.swift
//  NineInTeamTests
//
//  Created by Heonjin Ha on 2023/05/31.
//

import XCTest
import Combine
@testable import NineInTeam

final class FetchHashtags: NetworkServiceTests {

    // 모집 글 상세
    func test_fetch_team_detail() {
        // given
        let headerType = HeaderType.test
        let urlType = UrlType.testDomain
        let endPoint = "hashtags"

        // when
        let expectation = XCTestExpectation(description: "Hashtag 리스트 가져오기")

        // then
        sut.GET(headerType: headerType,
                urlType: urlType,
                endPoint: "\(endPoint)",
                parameters: [:],
                returnType: SubscribeHashtagList.self)
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
