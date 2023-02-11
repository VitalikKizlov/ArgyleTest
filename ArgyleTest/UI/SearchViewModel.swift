//
//  SearchViewModel.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 11.02.2023.
//

import Foundation
import Combine

final class SearchViewModel {

    // MARK: - Dependencies

    @Injected(\.searchProvider) private var searchProvider: SearchProviding

    // MARK: - Input

    @Published var searchText = "amaz"

    // MARK: - Properties

    @Published private(set) var state: LoadingState = .idle
    private var subscriptions: Set<AnyCancellable> = []

    init() {
        search()
    }

    // MARK: - Private

    private func search() {
        let parameters = SearchParameters(limit: 15, query: searchText)
        searchProvider.searchLinkItems(parameters)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.state = .failed(error)
                case .finished:
                    self.state = .idle
                }
            } receiveValue: { [weak self] results in
                print("Count ---", results.companies.count)
            }
            .store(in: &subscriptions)
    }
}

extension SearchViewModel {
    enum LoadingState {
        case idle
        case loading
        case loaded
        case failed(Error)
    }
}
