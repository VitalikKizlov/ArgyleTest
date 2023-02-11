//
//  SearchCollectionViewCellViewModel.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 11.02.2023.
//

import Foundation

struct SearchItemViewModel {
    let title: String
    let subtitle: String
    let imageUrl: URL?
}

extension SearchItemViewModel: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(subtitle)
        hasher.combine(imageUrl)
    }

    static func == (lhs: SearchItemViewModel, rhs: SearchItemViewModel) -> Bool {
        lhs.title == rhs.title && lhs.subtitle == rhs.subtitle && lhs.imageUrl == rhs.imageUrl
    }
}
