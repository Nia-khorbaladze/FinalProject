//
//  SuccessfulTransactionViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 22.01.25.
//

import UIKit
import SwiftUI

final class SuccessfulTransactionViewController: UIViewController {
    
    // MARK: - UI Elements
    private lazy var successImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Icons.successfulTransaction.rawValue)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var successText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.bold.uiFont(size: 32)
        label.textColor = UIColor(named: AppColors.white.rawValue)
        label.text = "Done!"
        
        return label
    }()
    
    private lazy var successSubText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.bold.uiFont(size: 14)
        label.textColor = UIColor(named: AppColors.lightGrey.rawValue)
        label.text = "Transaction was successful"
        
        return label
    }()
    
    private lazy var returnToHomeButton: UIHostingController<PrimaryButton> = {
        let hostingController = UIHostingController(
            rootView: PrimaryButton(
                title: "Return",
                isActive: true,
                action: { [weak self] in
                    self?.navigateToHomePage()
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
    
    // MARK: - Setup
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        setupUI()
        setupConstraints()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupUI() {
        view.addSubview(successImage)
        view.addSubview(successText)
        view.addSubview(successSubText)
        
        addChild(returnToHomeButton)
        view.addSubview(returnToHomeButton.view)
        returnToHomeButton.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            successText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            successImage.bottomAnchor.constraint(equalTo: successText.topAnchor, constant: 10),
            successImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successImage.heightAnchor.constraint(equalToConstant: 340),
            successImage.widthAnchor.constraint(equalToConstant: 340),
            successSubText.topAnchor.constraint(equalTo: successText.bottomAnchor, constant: 10),
            successSubText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            returnToHomeButton.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            returnToHomeButton.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            returnToHomeButton.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            returnToHomeButton.view.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func navigateToHomePage() {
        navigationController?.popToRootViewController(animated: true)
    }
}
