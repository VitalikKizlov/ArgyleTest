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

    @Published private(set) var searchText = ""
    let viewInputEventSubject = PassthroughSubject<ViewInputEvent, Never>()
    private lazy var viewInputEventPublisher = viewInputEventSubject.eraseToAnyPublisher()

    // MARK: - Properties

    @Published private(set) var state: LoadingState = .idle
    private var subscriptions: Set<AnyCancellable> = []

    // MARK: - Lifecycle

    init() {
        setupBindings()
    }

    // MARK: - Private

    private func setupBindings() {
        $searchText
            .debounce(for: 0.2, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { value in
                if value.isEmpty {
                    self.state = .loaded([])
                }

                return value.count > 1
            }
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.search()
            }
            .store(in: &subscriptions)

        viewInputEventPublisher
            .sink { [weak self] viewInputEvent in
                guard let self = self else { return }
                self.proceedViewInputEvent(viewInputEvent)
            }
            .store(in: &subscriptions)
    }

    private func proceedViewInputEvent(_ event: ViewInputEvent) {
        switch event {
        case .textDidChange(let text):
            searchText = text
        case .cancelButtonClicked:
            state = .loaded([])
        }
    }

    private func search() {
        state = .loading

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
                let viewModels = results.companies.map { company in
                    return SearchItemViewModel(
                        title: company.name,
                        subtitle: company.kind.rawValue,
                        imageUrl: company.logoURL
                    )
                }
                self?.state = .loaded(viewModels)
            }
            .store(in: &subscriptions)
    }
}

extension SearchViewModel {
    enum LoadingState: Equatable {
        case idle
        case loading
        case loaded([SearchItemViewModel])
        case failed(Error)

        static func == (lhs: SearchViewModel.LoadingState, rhs: SearchViewModel.LoadingState) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle):
                return true
            case (.loading, .loading):
                return true
            case (.loaded, .loaded):
                return true
            case (.failed, .failed):
                return true
            default:
                return false
            }
        }
    }
}

extension SearchViewModel {
    enum ViewInputEvent {
        case textDidChange(String)
        case cancelButtonClicked
    }
}
