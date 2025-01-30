//
//  AddressInputViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import UIKit

final class AddressInputViewController: UIViewController {
    private let coinSymbol: String
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: AppColors.darkGrey.rawValue)
        
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = UIColor(named: AppColors.white.rawValue)
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.navigateBack()
        }), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: AppColors.white.rawValue)
        label.font = Fonts.medium.uiFont(size: 18)
        label.text = "Send \(coinSymbol)"
        
        return label
    }()
    
    private lazy var addressInputField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter address"
        textField.textColor = UIColor(named: AppColors.white.rawValue)
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        
        if let placeholder = textField.placeholder {
            textField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [.foregroundColor: UIColor(named: AppColors.lightGrey.rawValue) ?? .lightGray]
            )
        }
        
        return textField
    }()
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: AppColors.lightGrey.rawValue)
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        return view
    }()
    
    init(coinSymbol: String) {
        self.coinSymbol = coinSymbol
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
        view.addSubview(headerView)
        headerView.addSubview(backButton)
        headerView.addSubview(headerTitle)
        view.addSubview(addressInputField)
        view.addSubview(bottomLine)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 13),
            backButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 13),
            backButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -13),
            
            headerTitle.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            addressInputField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            addressInputField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressInputField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addressInputField.heightAnchor.constraint(equalToConstant: 40),
            bottomLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: addressInputField.bottomAnchor, constant: 5)
        ])
    }
    private func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
}
