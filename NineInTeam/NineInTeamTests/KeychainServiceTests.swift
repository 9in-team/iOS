//
//  KeychainServiceTests.swift
//  NineInTeamTests
//
//  Created by HeonJin Ha on 2023/06/28.
//

import XCTest
@testable import NineInTeam

final class KeychainServiceTests: XCTestCase {
    
    var sut: KeychainManager!
    
    override func setUp() {
        sut = .shared
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testHandlingAccessToken() {
        // Given
        let dataString = "dummy-token"
        
        // When
        let passSave = XCTestExpectation(description: "토큰 저장 성공")
        let passGet = XCTestExpectation(description: "토큰 가져오기 성공")
        let tokenIsEqual = XCTestExpectation(description: "토큰 값 일치 확인 완료")
        let deleteSuccess = XCTestExpectation(description: "토큰이 삭제된 후에는 토큰 값을 불러오지 못해야 합니다.")

        // Then
        // 토큰 저장 및 가져오기
        do {
            try sut.saveToken(dataString, signInProvider: .kakao, tokenType: .accessToken)
            passSave.fulfill()
            
            let gettedToken = try sut.getToken(signInProvider: .kakao, tokenType: .accessToken)
            passGet.fulfill()
            
            XCTAssertEqual(gettedToken, dataString)
            tokenIsEqual.fulfill()
        } catch {
            XCTFail("DEBUG XCTest ERROR: \(error)")
        }
        
        // 토큰 삭제
        sut.deleteToken(signInProvider: .kakao)
        
        do {
            let token = try sut.getToken(signInProvider: .kakao, tokenType: .accessToken)
            XCTFail("토큰이 제거되지 않았습니다. \(token)")
        } catch {
            deleteSuccess.fulfill()
        }
        
        wait(for: [passSave, passGet, tokenIsEqual, deleteSuccess], timeout: 3.0)
    }
    
}
