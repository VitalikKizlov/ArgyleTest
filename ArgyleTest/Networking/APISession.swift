//
//  APISession.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 10.02.2023.
//

import Foundation
import Combine

struct ApiSession: APISessionProviding {
    private let apiSessionQueue = DispatchQueue(label: "com.quartr.API",
                                                qos: .default)

    private let decoder = JSONDecoder()

    func execute<T>(_ requestProvider: RequestProviding) -> AnyPublisher<T, Error> where T : Codable {

        decoder.dateDecodingStrategy = requestProvider.dateDecodingStrategy
        return URLSession.shared.dataTaskPublisher(for: requestProvider.urlRequest())
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .receive(on: apiSessionQueue)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()

    }
}

extension Publisher {
    func result(_ receiveResult: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        map(Result.success)
        .catch { Just(.failure($0)) }
        .sink(receiveValue: receiveResult)
    }
}
