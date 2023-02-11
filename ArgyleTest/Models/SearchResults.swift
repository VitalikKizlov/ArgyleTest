//
//  SearchResults.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 11.02.2023.
//

import Foundation

struct SearchResults: Codable {
    let companies: [Company]

    enum CodingKeys: String, CodingKey {
        case companies = "results"
    }
}
