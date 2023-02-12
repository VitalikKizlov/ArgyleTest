//
//  MockEndpoint.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 12.02.2023.
//

import Foundation

enum MockEndpoint: RequestProviding {
    case mock(SearchParameters)

    var path: String {
        return "/search"
    }

    var method: HTTPMethod {
        return .get
    }

    var parameters: [String : Any] {
        switch self {
        case .mock(let params):
            return [
                "limit": params.limit,
                "q": params.query
            ]
        }
    }

    var headerFields: [String : String] {
        return [:]
    }
}
