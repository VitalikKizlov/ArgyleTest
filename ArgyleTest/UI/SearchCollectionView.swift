//
//  SearchCollectionView.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 11.02.2023.
//

import UIKit

class SearchCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        collectionViewLayout = generateLayout()
        register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: TranscriptDetailCollectionViewCell.reuseIdentifier)
    }

    private func generateLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { _, _
            -> NSCollectionLayoutSection? in

            let size = NSCollectionLayoutSize(
                widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
                heightDimension: NSCollectionLayoutDimension.estimated(400)
            )
            let item = NSCollectionLayoutItem(layoutSize: size)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)

            return section
        }
        return layout
    }
}
