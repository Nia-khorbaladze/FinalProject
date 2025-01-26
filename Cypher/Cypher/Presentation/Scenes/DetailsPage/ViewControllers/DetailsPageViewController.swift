//
//  DetailsPageViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 17.01.25.
//

import UIKit
import SwiftUI

final class DetailsPageViewController: UIViewController {
    private let coinName: String
    private var viewModel: DetailsPageViewModel

    // MARK: - UI Elements
    private lazy var detailsPageView: UIHostingController<DetailsPageView> = {
        let hostingController = UIHostingController(
            rootView: DetailsPageView(viewModel: viewModel) {
                self.navigationController?.popViewController(animated: true)
            }
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    // MARK: - Initializer
    init(coinName: String, viewModel: DetailsPageViewModel) {
        self.coinName = coinName
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setup()
        viewModel.fetchCoinDetails(coinName: coinName)
    }
    
    // MARK: - Setup UI
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.greyBlue.rawValue)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        addChild(detailsPageView)
        view.addSubview(detailsPageView.view)
        detailsPageView.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            detailsPageView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsPageView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsPageView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsPageView.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
