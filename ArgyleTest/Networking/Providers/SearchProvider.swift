//
//  SearchProvider.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 11.02.2023.
//

import Foundation
import Combine

protocol SearchProviding {
    func searchLinkItems(_ parameters: SearchParameters) -> AnyPublisher<SearchResults, Error>
}

struct SearchProvider: SearchProviding {

    let apiSession: APISessionProviding

    init(apiSession: APISessionProviding = ApiSession()) {
        self.apiSession = apiSession
    }

    func searchLinkItems(_ parameters: SearchParameters) -> AnyPublisher<SearchResults, Error> {
        apiSession.execute(SearchEnpoint.linkItems(parameters))
            .eraseToAnyPublisher()
    }
}

