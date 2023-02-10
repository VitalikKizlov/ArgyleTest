//
//  RequestProviding.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 10.02.2023.
//

import Foundation

protocol RequestProviding {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var headerFields: [String: String] { get }
    var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }

    func urlRequest() -> URLRequest
}

extension RequestProviding {

    func authorizationHeader() -> [String: String] {
        guard let bearer = FirebaseManager.shared.accessToken else {
            return [:]
        }
        return [HTTPHeader.Key.authorization: HTTPHeader.Value.bearer(bearer)]
    }

    func urlRequest() -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = API.backendURL
        components.path = path

        if case .get = method, !parameters.isEmpty {
            components.queryItems = parameters.compactMap { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }

        guard let url = components.url else {
            preconditionFailure("Can't create URL")
        }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpMethod = method.rawValue

        let headers = headerFields.merge(with: authorizationHeader())

        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        print("Request ----", request)
        return request
    }

}
