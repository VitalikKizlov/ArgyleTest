//
//  EndpointTests.swift
//  ArgyleTestTests
//
//  Created by Vitalii Kizlov on 12.02.2023.
//

import XCTest
@testable import ArgyleTest

class EndpointTests: XCTestCase {

    let endpoint = MockEndpoint.mock(SearchParameters(limit: 15, query: "ama"))

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testRequestGeneration() {
        let request = endpoint.urlRequest()

        XCTAssertEqual(request.url?.host, API.backendURL)
        XCTAssertEqual(request.url?.path, endpoint.path)

        let limitParameterValue = request.url?.valueOfQueryParameter("limit")
        XCTAssertEqual(limitParameterValue, "15")

        let queryParameterValue = request.url?.valueOfQueryParameter("q")
        XCTAssertEqual(queryParameterValue, "ama")

        XCTAssertEqual(request.httpMethod, HTTPMethod.get.rawValue)
    }
}
