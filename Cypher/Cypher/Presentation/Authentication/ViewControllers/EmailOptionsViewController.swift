//
//  EmailOptionsViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 12.01.25.
//

import UIKit

final class EmailOptionsViewController: UIViewController {
    // MARK: - UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Your Email"
        label.font = Fonts.bold.uiFont(size: 24)
        label.textColor = UIColor(named: AppColors.white.rawValue)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add existing wallet or Create a new one"
        label.font = Fonts.regular.uiFont(size: 14)
        label.textColor = UIColor(named: AppColors.lightGrey.rawValue)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var continueWithGoogleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue with Google", for: .normal)
        button.backgroundColor = UIColor(hexString: "343434")
        button.setTitleColor(UIColor(named: AppColors.white.rawValue), for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var enterEmailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Enter Email manually", for: .normal)
        button.setTitleColor(UIColor(named: AppColors.white.rawValue), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(continueWithGoogleButton)
        view.addSubview(enterEmailButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            continueWithGoogleButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            continueWithGoogleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueWithGoogleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueWithGoogleButton.heightAnchor.constraint(equalToConstant: 50),
            
            enterEmailButton.topAnchor.constraint(equalTo: continueWithGoogleButton.bottomAnchor, constant: 16),
            enterEmailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

