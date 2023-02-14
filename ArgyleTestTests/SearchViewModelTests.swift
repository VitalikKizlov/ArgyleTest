//
//  SearchViewModelTests.swift
//  ArgyleTestTests
//
//  Created by Vitalii Kizlov on 11.02.2023.
//

import XCTest
@testable import ArgyleTest

class SearchViewModelTests: XCTestCase {

    private var sut: SearchViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SearchViewModel()
    }

    override func tearDownWithError() throws {
        sut = .none
        try super.tearDownWithError()
    }

    func testViewInputEvents() {
        sut = SearchViewModel()
        
        sut.viewInputEventSubject.send(.cancelButtonClicked)
        XCTAssertEqual(sut.state, SearchViewModel.LoadingState.loaded([], false))

        sut.viewInputEventSubject.send(.textDidChange("ama"))
        XCTAssertEqual(sut.searchText, "ama")

        sut.viewInputEventSubject.send(.textDidChange(""))
        XCTAssertEqual(sut.state, SearchViewModel.LoadingState.loaded([], false))
    }
}
