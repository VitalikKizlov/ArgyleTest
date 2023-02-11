//
//  SearchViewControllerTests.swift
//  ArgyleTestTests
//
//  Created by Vitalii Kizlov on 11.02.2023.
//

import XCTest
@testable import ArgyleTest

class SearchViewControllerTests: XCTestCase {

    private var sut: SearchViewController!
    private var viewModel: SearchViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = SearchViewModel()
        sut = SearchViewController(viewModel)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = .none
        viewModel = .none
        try super.tearDownWithError()
    }

    func testViewControllerInitializing() {
        viewModel = SearchViewModel()
        sut = SearchViewController(viewModel)
        XCTAssertNotNil(viewModel)
        XCTAssertNotNil(sut)
    }
}
