//
//  HomePageViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 13.01.25.
//

import UIKit
import SwiftUI

final class HomePageViewController: UIViewController {
    private let viewModel: CoinViewModel
    private let blurEffectService: BlurEffectService

    // MARK: - UI Elements
    private lazy var homePageTopView: UIHostingController<HomePageTopSectionView> = {
        let hostingController = UIHostingController(
            rootView: HomePageTopSectionView()
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    private lazy var trendingCoinsView: UIHostingController<CoinsListView> = {
        let hostingController = UIHostingController(
            rootView: CoinsListView(
                viewModel: viewModel,
                title: "Trending",
                onCoinTapped: { [weak self] coin in
                    guard let self = self else { return }
                    self.navigateToCoinDetails(coinName: coin.name)
                }
            )
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear

        viewModel.fetchCoins()

        return hostingController
    }()
    
    private lazy var profilePopupButtonView: UIHostingController<ProfilePopupButtonView> = {
        let hostingController = UIHostingController(
            rootView: ProfilePopupButtonView(action: openProfilePopup)
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
    init(viewModel: CoinViewModel, blurEffectService: BlurEffectService = BlurEffectService()) {
        self.viewModel = viewModel
        self.blurEffectService = blurEffectService
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
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        setupUI()
        setupConstraints()
    }
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        addChild(homePageTopView)
        contentView.addSubview(homePageTopView.view)
        homePageTopView.didMove(toParent: self)
        
        addChild(trendingCoinsView)
        contentView.addSubview(trendingCoinsView.view)
        trendingCoinsView.didMove(toParent: self)
        
        addChild(profilePopupButtonView)
        contentView.addSubview(profilePopupButtonView.view)
        profilePopupButtonView.didMove(toParent: self)
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
            profilePopupButtonView.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            profilePopupButtonView.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profilePopupButtonView.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            homePageTopView.view.topAnchor.constraint(equalTo: profilePopupButtonView.view.bottomAnchor, constant: 20),
            homePageTopView.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            homePageTopView.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            trendingCoinsView.view.topAnchor.constraint(equalTo: homePageTopView.view.bottomAnchor),
            trendingCoinsView.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trendingCoinsView.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            trendingCoinsView.view.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    private func openProfilePopup() {
        blurEffectService.addBlurEffect(to: view)
        let profilePopupVC = ProfilePopupViewController(blurEffectService: blurEffectService)
        profilePopupVC.modalPresentationStyle = .pageSheet
        profilePopupVC.sheetPresentationController?.delegate = profilePopupVC

        if let sheet = profilePopupVC.sheetPresentationController {
            sheet.detents = [
                .custom { context in
                    return 200
                }
            ]
            sheet.preferredCornerRadius = 40
        }
        
        present(profilePopupVC, animated: true)
    }
    
    private func navigateToCoinDetails(coinName: String) {
        let viewController = ViewControllerFactory().makeDetailsPageViewController(coinName: coinName)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
