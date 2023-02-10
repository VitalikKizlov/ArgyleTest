//
//  APISession.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 10.02.2023.
//

import Foundation
import Combine

protocol APISessionProviding {
    func execute<T: Codable>(_ requestProvider: RequestProviding) -> AnyPublisher<T, Error>
}
