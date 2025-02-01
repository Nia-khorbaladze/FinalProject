//
//  SuccessfulUsernameChangeViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import UIKit
import SwiftUI

final class SuccessfulUsernameChangeViewController: UIViewController {
    // MARK: - UI Elements
    private lazy var successfulChangeView: UIHostingController<SuccessfulUsernameChangeView> = {
        let hostingController = UIHostingController(
            rootView: SuccessfulUsernameChangeView()
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    private lazy var returnButton: UIHostingController<PrimaryButton> = {
        let hostingController = UIHostingController(
            rootView: PrimaryButton(
                title: "Return",
                isActive: true,
                action: { [weak self] in
                    self?.navigateBack()
                }
            )
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
    
    // MARK: - UI Setup
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        addChild(successfulChangeView)
        view.addSubview(successfulChangeView.view)
        successfulChangeView.didMove(toParent: self)
        
        addChild(returnButton)
        view.addSubview(returnButton.view)
        returnButton.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            successfulChangeView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            successfulChangeView.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            returnButton.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            returnButton.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            returnButton.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            returnButton.view.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Functions
    private func navigateBack() {
        navigationController?.popToRootViewController(animated: true)
    }
}
