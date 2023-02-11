//
//  API.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 11.02.2023.
//

import Foundation

enum API {
    static var backendURL: String {
        do {
            return try BuildConfiguration.value(for: "API_BASE_URL")
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    static var username: String {
        do {
            return try BuildConfiguration.value(for: "API_KEY_ID")
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    static var password: String {
        do {
            return try BuildConfiguration.value(for: "API_SECRET_KEY")
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
