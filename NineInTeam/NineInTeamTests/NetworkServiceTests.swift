//
//  NineInTeamTestFetchTeams.swift
//  NineInTeamTests
//
//  Created by Heonjin Ha on 2023/05/17.
//

import XCTest
import Combine
@testable import NineInTeam

class NetworkServiceTests: XCTestCase {

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

}
