//
//  SearchViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import UIKit
import SwiftUI


final class SearchViewController: UIViewController {
    private let viewModel: CoinViewModel
    
    // MARK: - UI Elements
    private lazy var searchView: UIHostingController<SearchPageView> = {
        let hostingController = UIHostingController(
            rootView: SearchPageView(
                viewModel: viewModel,
                onCoinTapped: { [weak self] coin in
                    guard let self = self else { return }
                    self.navigateToCoinDetails(coinName: coin.name)
                }
            )
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    // MARK: - Initializers
    init(viewModel: CoinViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - UI Setup
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        addChild(searchView)
        view.addSubview(searchView.view)
        searchView.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func navigateToCoinDetails(coinName: String) {
        let viewController = ViewControllerFactory().makeDetailsPageViewController(coinName: coinName)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
