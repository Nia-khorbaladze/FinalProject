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
    private lazy var emptyPortfolioView: UIHostingController<EmptyPortfolioView> = {
        let hostingController = UIHostingController(
            rootView: EmptyPortfolioView()
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
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        addChild(emptyPortfolioView)
        view.addSubview(emptyPortfolioView.view)
        emptyPortfolioView.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emptyPortfolioView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyPortfolioView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyPortfolioView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyPortfolioView.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
