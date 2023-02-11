//
//  SearchEndpoint.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 11.02.2023.
//

import Foundation

enum SearchEnpoint: RequestProviding {

    case linkItems(SearchParameters)

    var path: String {
        return "/v1/search/link-items"
    }

    var method: HTTPMethod {
        return .get
    }

    var parameters: [String : Any] {
        switch self {
        case .linkItems(let params):
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
