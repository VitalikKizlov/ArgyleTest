//
//  ViewController.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 10.02.2023.
//

import UIKit

class SearchViewController: UIViewController {

    private let viewModel: SearchViewModel

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
        // Do any additional setup after loading the view.
    }


}

