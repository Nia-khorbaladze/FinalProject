//
//  FavoritesPageViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import UIKit
import SwiftUI

final class FavoritesPageViewController: UIViewController {
    private let viewModel: FavoritesViewModel
    
    // MARK: - UI Elements
    private lazy var favoriteCoinsListView: UIHostingController<FavoriteCoinsView> = {
        let hostingController = UIHostingController(
            rootView: FavoriteCoinsView(viewModel: viewModel)
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    // MARK: - Initializers
    init(viewModel: FavoritesViewModel) {
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
    
    // MARK: - Setup
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        addChild(favoriteCoinsListView)
        view.addSubview(favoriteCoinsListView.view)
        favoriteCoinsListView.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            favoriteCoinsListView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteCoinsListView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteCoinsListView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteCoinsListView.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
