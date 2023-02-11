//
//  SearchCollectionViewCell.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 11.02.2023.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell {

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

    // MARK: - Setup

    public func setup(with viewModel: TranscriptDetailCellViewModel) {
        transcriptCollectionViewCellView.setup(with: viewModel)
    }

    public func updateHighlight(for time: Double) {
        transcriptCollectionViewCellView.updateHighlight(for: time)
    }

    // MARK: - Setup ContentView

    private func setupContentView() {
        contentView.addSubview(searchCollectionViewCellView)
        let constraints = searchCollectionViewCellView.constraintsForAnchoringTo(boundsOf: contentView)
        NSLayoutConstraint.activate(constraints)
    }
}
