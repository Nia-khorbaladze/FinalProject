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
    
    private lazy var trendingCoinsList: UIHostingController<TrendingCoinsListView> = {
        let hostingController = UIHostingController(
            rootView: TrendingCoinsListView()
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
                action: { }
            )
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        addChild(swapCoinsView)
        contentView.addSubview(swapCoinsView.view)
        swapCoinsView.didMove(toParent: self)
        
        addChild(trendingCoinsList)
        contentView.addSubview(trendingCoinsList.view)
        trendingCoinsList.didMove(toParent: self)
        
        addChild(swapButton)
        contentView.addSubview(swapButton.view)
        swapButton.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            swapCoinsView.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            swapCoinsView.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            swapCoinsView.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            swapButton.view.topAnchor.constraint(equalTo: swapCoinsView.view.bottomAnchor),
            swapButton.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            swapButton.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            trendingCoinsList.view.topAnchor.constraint(equalTo: swapButton.view.bottomAnchor, constant: 30),
            trendingCoinsList.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trendingCoinsList.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            trendingCoinsList.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
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
                    action: { }
                )
            }
            .store(in: &cancellables)
    }
}
