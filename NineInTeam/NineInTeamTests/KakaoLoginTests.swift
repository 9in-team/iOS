//
//  KakaoLoginTests.swift
//  NineInTeamTests
//
//  Created by HeonJin Ha on 2023/06/28.
//

import XCTest
import Combine
import KakaoSDKCommon
@testable import NineInTeam

struct TestKakaoLogoutResponse: Decodable {
    let id: Float
}

final class KakaoLoginTests: XCTestCase {
    
    var sut: KakaoSignService!
    var keychainManager: KeychainManager!
    var networkService: NetworkService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        sut = .init()
        keychainManager = .shared
        networkService = .init()
        cancellables = .init()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        cancellables = nil
        networkService = nil
        keychainManager = nil
        sut = nil
    }

    // 토큰으로 로그인 세션 받기 테스트 (세션 확인)
    func testKakaoLogin() {
        // Given
        // 실제 로그인 토큰으로 작업하여야 합니다.
        let authenticatedLoginToken = "" // <- 실제 키 투입.
ㄹ        // When
        let expectation1 = XCTestExpectation(description: "testLogin Completion을 받았습니다.")
        let expectation2 = XCTestExpectation(description: "로그인에 성공했습니다.")
        
        // Then
        sut.testLogin(accesstoken: authenticatedLoginToken) { error in
            expectation1.fulfill()
            if let error = error {
                if let keychainError = error as? KeychainError {
                    print("XCT DEBUG: \(#function) \(error)")
                    // 알럿 -> 키체인 에러 (사용자: 토큰 저장 실패)
                } else if let kakaoAuthError = error as? KakaoAuthError {
                    print("XCT DEBUG: \(#function) \(error)")
                    // 알럿 -> 키체인 에러
                } else if let error = error as? KakaoSDKCommon.SdkError {
                    print("XCT DEBUG: \(#function) \(error)")
                }
                XCTFail("카카오 로그인 에러발생 \(error)")
            } else {
                expectation2.fulfill()
            }
        }
        
        wait(for: [expectation1, expectation2], timeout: 3.0)
    }
                
    // 로그아웃 테스트 (실제 로그인 된 토큰으로 진행 필요)
    // POST Error 발생 시 Crash 발생
    func testLogout() {
        // Given
        let authenticatedLoginToken = "jeMSKu_N8_PwPSn8lnthiS6xHrGmYrw9zKEDB5jiCisM0wAAAYkLOX-4"
        UserAuthManager.shared.isSingIn = true
        UserAuthManager.shared.userData = .init(id: 99999999999,
                                                email: "test",
                                                nickName: "test",
                                                profileImageUrl: "test",
                                                signInProvider: .kakao)
        
        // When
        let expectation1 = XCTestExpectation(description: "sut의 로그아웃 메소드 검증이 완료되었습니다.")
        let expectation2 = XCTestExpectation(description: "Post요청에 성공했습니다.")
        
        // Then
        // 아래 2개의 Assert Test 용으로 테스트 환경 에선 실제 로그아웃은 실패 함.
        UserAuthManager.shared.logout()
        XCTAssertFalse(UserAuthManager.shared.isSingIn, "로그아웃 후에는 로그인 상태가 false여야 합니다.")
        XCTAssertNil(UserAuthManager.shared.userData, "로그아웃 후에는 유저데이터가 nil 값을 가져야합니다.")
        expectation1.fulfill()
        
        // 실제로 로그아웃 작업.
        networkService.POST(headerType: .testKakaoApi(token: authenticatedLoginToken),
                            urlType: .kakaoApi,
                            endPoint: "v1/user/logout",
                            returnType: TestKakaoLogoutResponse.self)
        .sink { result in
            switch result {
            case .finished:
                expectation2.fulfill()
            case .failure(let error):
                print("⚙️ XCTEST DEBUG: Post Failure : \(error)")
                XCTFail("로그아웃 실패")
            }
        } receiveValue: { response in
            print("⚙️ XCTEST DEBUG: Received Value: \(response)")
        }
        .store(in: &cancellables)
        
        sut.testLogin(accesstoken: authenticatedLoginToken) { error in
            expectation1.fulfill()
            if let error = error {
                if let keychainError = error as? KeychainError {
                    print("DEBUG: \(#function) \(error)")
                    // 알럿 -> 키체인 에러 (사용자: 토큰 저장 실패)
                } else if let kakaoAuthError = error as? KakaoAuthError {
                    print("DEBUG: \(#function) \(error)")
                    // 알럿 -> 키체인 에러
                } else if let error = error as? KakaoSDKCommon.SdkError {
                    print("DEBUG: \(#function) \(error)")
                }
                XCTFail("카카오 로그인 에러발생 \(error)")
            } else {
                expectation2.fulfill()
            }
        }
        
        wait(for: [expectation1, expectation2], timeout: 3.0)
    }
}
