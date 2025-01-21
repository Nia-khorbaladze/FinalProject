//
//  AddWalletViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 12.01.25.
//

import Foundation
import UIKit
import SwiftUI

final class AddWalletViewController: UIViewController {
    private let state: AuthenticationState
    private let blurEffectService: BlurEffectService
    
    // MARK: - UI Elements
    private let navigateBackButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.isEnabled = true
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .white
        
        return button
    }()

    private lazy var addWalletView: UIHostingController<AddWalletView> = {
        let hostingController = UIHostingController(rootView: AddWalletView())
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    private lazy var primaryButton: UIHostingController<PrimaryButton> = {
        let title = state == .register ? "Register" : "Continue with Email"
        let hostingController = UIHostingController(
            rootView: PrimaryButton(
                title: title,
                isActive: true,
                action: { [weak self] in self?.showEmailOptions() }
            )
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    // MARK: - Initializers
    init(state: AuthenticationState, blurEffectService: BlurEffectService = BlurEffectService()) {
        self.state = state
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
    
    // MARK: - UI Setup
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        setupUI()
        setupConstraints()
        setupBackButton()
    }
    
    private func setupUI() {
        addChild(addWalletView)
        view.addSubview(addWalletView.view)
        addWalletView.didMove(toParent: self)
        
        addChild(primaryButton)
        view.addSubview(primaryButton.view)
        primaryButton.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            addWalletView.view.topAnchor.constraint(equalTo: view.topAnchor),
            addWalletView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addWalletView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addWalletView.view.bottomAnchor.constraint(equalTo: primaryButton.view.topAnchor, constant: -20),
            
            primaryButton.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            primaryButton.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            primaryButton.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            primaryButton.view.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupBackButton() {
        navigateBackButton.addAction(UIAction(handler: { [weak self] _ in
            self?.navigateBack()
        }), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigateBackButton)
    }
    
    private func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Functions
    private func showEmailOptions() {
        blurEffectService.addBlurEffect(to: view)
        
        let emailOptionsVC = EmailOptionsViewController(blurEffectService: blurEffectService)
        emailOptionsVC.delegate = self
        emailOptionsVC.modalPresentationStyle = .pageSheet
        emailOptionsVC.sheetPresentationController?.delegate = emailOptionsVC
        
        if let sheet = emailOptionsVC.sheetPresentationController {
            sheet.detents = [
                .custom { context in
                    return 200
                }
            ]
            sheet.preferredCornerRadius = 40
        }
        
        present(emailOptionsVC, animated: true)
    }
}

// MARK: - Extensions
extension AddWalletViewController: EmailOptionsViewControllerDelegate {
    func didTapEnterEmailManually() {
        blurEffectService.removeBlurEffect()
        let credentialsInputVC = CredentialsInputViewController(state: state)
        navigationController?.pushViewController(credentialsInputVC, animated: true)
    }
}

extension AddWalletViewController: UISheetPresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        blurEffectService.removeBlurEffect()
    }
}

