//
//  InjectedKeys.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 11.02.2023.
//

import Foundation

struct SearchProviderKey: InjectionKey {
    static var currentValue: SearchProviding = ProcessInfo.isRunningUnitTests ? MockSearchProvider() : SearchProvider()
}
