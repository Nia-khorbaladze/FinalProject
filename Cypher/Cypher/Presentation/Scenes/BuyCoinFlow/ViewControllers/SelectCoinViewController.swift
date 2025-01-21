//
//  SelectCoinViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 21.01.25.
//

import UIKit
import SwiftUI

final class SelectCoinViewController: UIViewController {
    private let viewModel: CoinViewModel
    
    // MARK: - UI Elements
    private lazy var selectCoinView: UIHostingController<SelectCoinView> = {
        let hostingController = UIHostingController(
            rootView: SelectCoinView(
                viewModel: viewModel,
                onCoinTap: { [weak self] coin in
                    let buyVC = BuyCoinViewController(
                        coinSymbol: coin.symbol.uppercased(),
                        currentPrice: coin.currentPrice
                    )
                    self?.navigationController?.pushViewController(buyVC, animated: true)
                },
                onCloseTap: { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
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
    
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        addChild(selectCoinView)
        view.addSubview(selectCoinView.view)
        selectCoinView.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            selectCoinView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            selectCoinView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectCoinView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectCoinView.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
