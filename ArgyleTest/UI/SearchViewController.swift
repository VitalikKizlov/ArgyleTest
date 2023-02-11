//
//  ViewController.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 10.02.2023.
//

import UIKit

class SearchViewController: UIViewController {

    private let viewModel: SearchViewModel

    enum Section: Int, Hashable, CaseIterable {
        case main
    }

    @AutoLayoutable private var collectionView = SearchCollectionView()

    typealias DataSource = UICollectionViewDiffableDataSource<Section, SearchCollectionViewCellViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, SearchCollectionViewCellViewModel>
    private lazy var dataSource = setupDataSource()

    // MARK: - Init

    init(_ viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupUI()
        setupLayout()
        setUpBindings()
    }

    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self

        let constraints = collectionView.constraintsForAnchoringTo(boundsOf: view)
        NSLayoutConstraint.activate(constraints)

        collectionView.contentInset = collectionViewContentInsets
        collectionView.scrollIndicatorInsets = collectionViewContentInsets
    }

    private func registerCells() {

    }

    private func setupDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item -> UICollectionViewCell? in
            guard let self = self else { return nil }

            if let category = item as? Category {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier:
                    FullWidthCategoryCollectionViewCell.reuseIdentifer,
                    for: indexPath
                ) as? FullWidthCategoryCollectionViewCell
                cell?.viewModel = FullWidthCategoryCellViewModel(category: category)
                return cell
            } else if let company = item as? Company {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier:
                    CompanyCollectionViewCell.reuseIdentifer,
                    for: indexPath
                ) as? CompanyCollectionViewCell
                else { return UICollectionViewCell() }
                self.roundSectionCorners(
                    indexPath: indexPath,
                    cell: cell,
                    numberOfItems: self.viewModel.searchResults.count
                )

                let model = CompanyCollectionCellViewModel(company: company, featureTag: .onboarding)
                cell.setupViewModel(model)
                cell.delegate = self

                return cell
            } else {
                fatalError("Unknown cell type")
            }
        }

        return dataSource
    }

    func setupLayout() {
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider: { section, _ -> NSCollectionLayoutSection? in
                let size = NSCollectionLayoutSize(
                    widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
                    heightDimension: NSCollectionLayoutDimension.absolute(80)
                )
                let item = NSCollectionLayoutItem(layoutSize: size)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0.5, trailing: 24)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            }
        )
    }

}

