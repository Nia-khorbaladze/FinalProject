//
//  SwapPageViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import UIKit
import SwiftUI
import Combine

final class SwapPageViewController: UIViewController {
    private let viewModel: SwapViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Elements
    private lazy var swapCoinsView: UIHostingController<SwapCoinsView> = {
        let hostingController = UIHostingController(
            rootView: SwapCoinsView(viewModel: viewModel)
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    private lazy var swapButton: UIHostingController<PrimaryButton> = {
        let hostingController = UIHostingController(
            rootView: PrimaryButton(
                title: "Swap",
                isActive: viewModel.isButtonActive,
                action: { [weak self] in
                    self?.handleSwapAction()
                }
            )
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    // MARK: - Initializers
    init(viewModel: SwapViewModel) {
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
        setupBindings()
    }
    
    private func setupUI() {
        addChild(swapCoinsView)
        view.addSubview(swapCoinsView.view)
        swapCoinsView.didMove(toParent: self)
        
        addChild(swapButton)
        view.addSubview(swapButton.view)
        swapButton.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            swapCoinsView.view.topAnchor.constraint(equalTo: view.topAnchor),
            swapCoinsView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swapCoinsView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            swapButton.view.topAnchor.constraint(equalTo: swapCoinsView.view.bottomAnchor),
            swapButton.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swapButton.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Functions
    private func setupBindings() {
        viewModel.$isButtonActive
            .receive(on: RunLoop.main)
            .sink { [weak self] isActive in
                guard let self = self else { return }
                self.swapButton.rootView = PrimaryButton(
                    title: "Swap",
                    isActive: isActive,
                    action: isActive ? { self.handleSwapAction() } : {}
                )
            }
            .store(in: &cancellables)
    }
    
    private func handleSwapAction() {
        Task {
            let success = await viewModel.swapCoins()
            
            await MainActor.run { [weak self] in
                if success {
                    let successVC = SuccessfulTransactionViewController()
                    self?.navigationController?.pushViewController(successVC, animated: true)
                } else {
                    self?.showError("Please try again later.")
                }
            }
        }
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
