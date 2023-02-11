//
//  MockAPISession.swift
//  ArgyleTestTests
//
//  Created by Vitalii Kizlov on 11.02.2023.
//

import Combine

struct MockSearchProvider: SearchProviding {
    func searchLinkItems(_ parameters: SearchParameters) -> AnyPublisher<SearchResults, Error> {
        Just(SearchResults(companies: [Company(name: "Amazon", kind: Kind.employer, logoStringURL: "www")]))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
