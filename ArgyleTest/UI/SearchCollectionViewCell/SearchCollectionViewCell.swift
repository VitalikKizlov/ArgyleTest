//
//  SearchCollectionViewCell.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 11.02.2023.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: SearchCollectionViewCell.self)

    @AutoLayoutable private var searchCollectionViewCellView =
    SearchCollectionViewCellView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        searchCollectionViewCellView.prepareForReuse()
    }

    // MARK: - Setup

    func setup(_ viewModel: SearchItemViewModel) {
        searchCollectionViewCellView.setup(viewModel)
    }

    // MARK: - Setup ContentView

    private func setupContentView() {
        contentView.addSubview(searchCollectionViewCellView)
        let constraints = searchCollectionViewCellView.constraintsForAnchoringTo(boundsOf: contentView)
        NSLayoutConstraint.activate(constraints)
    }
}
