//
//  PortfolioViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import UIKit
import SwiftUI

final class PortfolioViewController: UIViewController {
    private let viewModel: PortfolioViewModel

    // MARK: - UI Elements
    private lazy var portfolioView: UIHostingController<PortfolioView> = {
        let hostingController = UIHostingController(
            rootView: PortfolioView(viewModel: viewModel)
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()

    // MARK: - Initializers
    init(viewModel: PortfolioViewModel) {
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        addChild(portfolioView)
        view.addSubview(portfolioView.view)
        portfolioView.didMove(toParent: self)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            portfolioView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            portfolioView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            portfolioView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            portfolioView.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
