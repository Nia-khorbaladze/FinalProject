//
//  SearchViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import UIKit
import SwiftUI


final class SearchViewController: UIViewController {
    private let viewModel: SearchViewModel
    private lazy var searchView: UIHostingController<SearchPageView> = {
        let hostingController = UIHostingController(
            rootView: SearchPageView()
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
}
