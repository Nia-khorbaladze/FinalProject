//
//  SwapPageViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import UIKit
import SwiftUI

final class SwapPageViewController: UIViewController {
    private lazy var swapCoinsView: UIHostingController<SwapCoinsView> = {
        let hostingController = UIHostingController(
            rootView: SwapCoinsView()
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
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        addChild(swapCoinsView)
        contentView.addSubview(swapCoinsView.view)
        swapCoinsView.didMove(toParent: self)
        
        addChild(trendingCoinsList)
        contentView.addSubview(trendingCoinsList.view)
        trendingCoinsList.didMove(toParent: self)
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
            
            trendingCoinsList.view.topAnchor.constraint(equalTo: swapCoinsView.view.bottomAnchor),
            trendingCoinsList.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trendingCoinsList.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            trendingCoinsList.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
