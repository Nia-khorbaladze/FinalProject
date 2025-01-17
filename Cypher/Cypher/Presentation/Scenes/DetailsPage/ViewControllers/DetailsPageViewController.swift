//
//  DetailsPageViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 17.01.25.
//

import UIKit
import SwiftUI

final class DetailsPageViewController: UIViewController {
    // MARK: - UI Elements
    private lazy var detailsPageView: UIHostingController<DetailsPageView> = {
        let hostingController = UIHostingController(
            rootView: DetailsPageView {
                self.navigationController?.popViewController(animated: true)
            }
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
