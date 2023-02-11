//
//  ViewController.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 10.02.2023.
//

import UIKit
import Combine

class SearchViewController: UIViewController {

    private let viewModel: SearchViewModel

    enum Section: Int, Hashable {
        case main
    }

    @AutoLayoutable private var collectionView = SearchCollectionView()

    typealias DataSource = UICollectionViewDiffableDataSource<Section, SearchItemViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, SearchItemViewModel>
    private lazy var dataSource = setupDataSource()

    private var subscriptions: Set<AnyCancellable> = []

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
        setUpBindings()
        configureCollectionView()
    }

    private func setUpBindings() {
        viewModel
            .$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }

                switch state {
                case .idle:
                    break
                case .failed(let error):
                    print("show alert")
                case .loading:
                    print("show spinner")
                case .loaded(let viewModels):
                    self.updateSections(viewModels)
                }
            }
            .store(in: &subscriptions)
    }

    private func configureCollectionView() {
        view.addSubview(collectionView)

        let constraints = collectionView.constraintsForAnchoringTo(boundsOf: view)
        NSLayoutConstraint.activate(constraints)

//        collectionView.contentInset = collectionViewContentInsets
//        collectionView.scrollIndicatorInsets = collectionViewContentInsets
    }

    private func setupDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item -> UICollectionViewCell? in
            guard let self = self else { return nil }

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell
            else { return nil }

            cell.setup(item)

            return cell
        }

        return dataSource
    }

    private func updateSections(_ viewModels: [SearchItemViewModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(viewModels, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

