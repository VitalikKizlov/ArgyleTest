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

    func urlRequest() -> URLRequest
}

extension RequestProviding {

    func authorizationHeader() -> [String: String] {
        let loginString = "\(API.username):\(API.password)"

        guard let loginData = loginString.data(using: String.Encoding.utf8)
        else { return [:] }
        let base64LoginString = loginData.base64EncodedString()

        return [HTTPHeader.authorization: "Basic \(base64LoginString)"]
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
