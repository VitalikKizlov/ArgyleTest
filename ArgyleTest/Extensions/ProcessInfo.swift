//
//  ProcessInfo.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 11.02.2023.
//

import Foundation

extension ProcessInfo {
    static var isRunningUnitTests: Bool {
        Self.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
}
