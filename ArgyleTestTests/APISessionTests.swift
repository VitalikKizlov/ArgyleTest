//
//  APISessionTests.swift
//  ArgyleTestTests
//
//  Created by Vitalii Kizlov on 11.02.2023.
//

import XCTest
@testable import ArgyleTest
import Combine

class APISessionTests: XCTestCase {

    @Injected(\.searchProvider) private var searchProvider: SearchProviding
    private var subscriptions: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testSearchResponse() {
        let expectedResponse = SearchResults(
            companies: [Company(name: "Amazon",
                                kind: Kind.employer,
                                logoStringURL: "www")])
        let expectation = XCTestExpectation(description: "search results")

        searchProvider
            .searchLinkItems(SearchParameters(limit: 15, query: "q"))
            .sink(receiveCompletion: { _ in }) { response in
            XCTAssertEqual(response, expectedResponse)
            expectation.fulfill()
        }
        .store(in: &subscriptions)

        wait(for: [expectation], timeout: 1)
    }
}
