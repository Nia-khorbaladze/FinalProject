//
//  ProfilePopupViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import UIKit
import SwiftUI

final class ProfilePopupViewController: UIViewController {
    private let blurEffectService: BlurEffectService
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "iphone.and.arrow.right.outward"), for: .normal)
        button.tintColor = UIColor(named: AppColors.lightGrey.rawValue)
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = UIColor(named: AppColors.lightGrey.rawValue)
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.closeButtonTapped()
        }), for: .touchUpInside)
        
        return button
    }()
    
    init(blurEffectService: BlurEffectService = BlurEffectService()) {
        self.blurEffectService = blurEffectService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        view.addSubview(closeButton)
        view.addSubview(logoutButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.centerYAnchor.constraint(equalTo: logoutButton.centerYAnchor)
        ])
    }
    
    private func closeButtonTapped() {
        blurEffectService.removeBlurEffect()
        dismiss(animated: true)
    }
}

// MARK: - Extensions
extension ProfilePopupViewController: UISheetPresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        blurEffectService.removeBlurEffect()
    }
}
