//
//  TermsViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 11.01.25.
//

import Foundation
import UIKit

final class TermsViewController: UIViewController {
    // MARK: - UI Elements
    private lazy var header: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: "505050")
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        return view
    }()
    
    private lazy var termsViewTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Terms of Service"
        label.textColor = UIColor(named: AppColors.white.rawValue)
        label.font = Fonts.semiBold.uiFont(size: 22)
        
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = Fonts.regular.uiFont(size: 13)
        button.setTitleColor(UIColor(named: AppColors.white.rawValue), for: .normal)
        button.addAction(UIAction { [weak self] _ in
            self?.closeTermsOfService()
        }, for: .touchUpInside)
        
        return button
    }()
    
    private lazy var termsText: UITextView = {
        let textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.font = Fonts.regular.uiFont(size: 15)
        textview.isUserInteractionEnabled = false
        textview.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        textview.textColor = UIColor(named: AppColors.white.rawValue)
        
        return textview
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - UI Setup
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        setupConstraints()
        
        termsText.text = """
        1. This app is a demo and does not involve real cryptocurrency transactions.

        2. The app collects minimal user data for functionality purposes. 

        3. By using the app, you agree to these terms.
        """
        
    }
    
    private func setupConstraints() {
        view.addSubview(termsText)
        header.addSubview(termsViewTitle)
        header.addSubview(cancelButton)
        view.addSubview(header)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            termsViewTitle.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            termsViewTitle.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            
            cancelButton.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 10),
            cancelButton.centerYAnchor.constraint(equalTo: termsViewTitle.centerYAnchor),
            
            termsText.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 15),
            termsText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            termsText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            termsText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
    }
    
    // MARK: - Functions
    private func closeTermsOfService() {
        self.dismiss(animated: true, completion: nil)
    }
}
