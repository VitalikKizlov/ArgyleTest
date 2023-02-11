//
//  Dictionary.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 11.02.2023.
//

import Foundation

extension Dictionary {
    func merge(with dictionary: [Key: Value], overwriteExistingValues: Bool = false) -> [Key: Value] {
        var copy = self
        copy.merge(dictionary) { current, new -> Value in
            overwriteExistingValues ? new : current
        }
        return copy
    }
}

