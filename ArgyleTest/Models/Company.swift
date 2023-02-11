//
//  Company.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 11.02.2023.
//

import Foundation

struct Company: Codable {
    let name: String
    let kind: Kind
    let logoStringURL: String

    var logoURL: URL? {
        URL(string: logoStringURL)
    }

    enum CodingKeys: String, CodingKey {
        case name
        case kind
        case logoStringURL = "logo_url"
    }
}

enum Kind: String, Codable {
    case employer = "employer"
    case gig = "gig"
    case platform = "platform"
}

extension Company: Equatable {}
