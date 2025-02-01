//
//  BuyCoinViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 21.01.25.
//

import UIKit
import SwiftUI

final class BuyCoinViewController: UIViewController {
    private let viewModel: BuyCoinViewModel
    private var buttonBottomConstraint: NSLayoutConstraint!
    private var keyboardHandler: KeyboardHandler?

    // MARK: - UI Elements
    private lazy var headerView: HeaderView = {
        let header = HeaderView(title: "Buy")
        header.translatesAutoresizingMaskIntoConstraints = false
        header.onBackButtonTapped = { [weak self] in
            self?.navigateBack()
        }
        return header
    }()
    
    private lazy var amountField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.text = "$ 0"
        textfield.font = Fonts.bold.uiFont(size: 48)
        textfield.textColor = UIColor(named: AppColors.white.rawValue)
        textfield.keyboardType = .decimalPad
        textfield.textAlignment = .center
        textfield.tintColor = .clear
        textfield.delegate = self
        
        return textfield
    }()
    
    private lazy var coinAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.regular.uiFont(size: 20)
        label.textColor = UIColor(named: AppColors.lightGrey.rawValue)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var quickAmountStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    private lazy var buyButton: UIHostingController<PrimaryButton> = {
        let hostingController = UIHostingController(
            rootView: PrimaryButton(
                title: "Buy",
                isActive: false,
                action: { [weak self] in
                    self?.handleBuyButtonTap()
                }
            )
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    // MARK: - Initializers
    init(coinSymbol: String, currentPrice: Double, coinName: String, imageURL: String) {
        self.viewModel = Dependencies.shared.makeBuyCoinViewModel(
            coinSymbol: coinSymbol,
            currentPrice: currentPrice,
            imageURL: imageURL,
            coinName: coinName
        )
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        keyboardHandler = nil
        view.gestureRecognizers?.removeAll()  
    }
    
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
        setupQuickAmountButtons()
        
        keyboardHandler = KeyboardHandler(view: view, bottomConstraint: buttonBottomConstraint)
        
        viewModel.onAmountUpdate = { [weak self] in
            self?.updateUI()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        view.addSubview(headerView)
        view.addSubview(amountField)
        view.addSubview(coinAmountLabel)
        view.addSubview(quickAmountStack)
        addChild(buyButton)
        view.addSubview(buyButton.view)
        buyButton.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        buttonBottomConstraint = buyButton.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 55),
            
            amountField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 40),
            amountField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amountField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            amountField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            coinAmountLabel.topAnchor.constraint(equalTo: amountField.bottomAnchor, constant: 8),
            coinAmountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            quickAmountStack.topAnchor.constraint(equalTo: coinAmountLabel.bottomAnchor, constant: 24),
            quickAmountStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            quickAmountStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            quickAmountStack.heightAnchor.constraint(equalToConstant: 44),
            
            buttonBottomConstraint,
            buyButton.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buyButton.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buyButton.view.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func updateUI() {
        amountField.text = viewModel.formatAmount()
        coinAmountLabel.text = viewModel.getCryptoDisplay()
        buyButton.rootView = PrimaryButton(
            title: "Buy",
            isActive: viewModel.isButtonActive,
            action: { [weak self] in
                self?.handleBuyButtonTap()
            }
        )
    }
    
    private func setupQuickAmountButtons() {
        let amounts = [100, 500, 1000]
        amounts.forEach { amount in
            let button = createQuickAmountButton(amount: amount)
            quickAmountStack.addArrangedSubview(button)
        }
    }
    
    private func createQuickAmountButton(amount: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("$\(amount)", for: .normal)
        button.backgroundColor = UIColor(named: AppColors.darkGrey.rawValue)
        button.setTitleColor(UIColor(named: AppColors.white.rawValue), for: .normal)
        button.layer.cornerRadius = 15
        button.tag = amount
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.quickAmountTapped(button)
        }), for: .touchUpInside)
        return button
    }
    
    private func quickAmountTapped(_ sender: UIButton) {
        let amount = Double(sender.tag)
        let isSelected = viewModel.handleQuickAmountTap(amount)
        
        quickAmountStack.arrangedSubviews.forEach { button in
            button.backgroundColor = UIColor(named: AppColors.darkGrey.rawValue)
        }
        
        if isSelected {
            sender.backgroundColor = UIColor(named: AppColors.accent.rawValue)
        }
    }
    
    private func handleBuyButtonTap() {
        if !viewModel.isButtonActive { return }
        
        Task {
            do {
                try await viewModel.savePurchase()
                DispatchQueue.main.async { [weak self] in
                    self?.navigationController?.pushViewController(SuccessfulTransactionViewController(), animated: true)
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.showErrorAlert()
                }
            }
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extensions
extension BuyCoinViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        let isNumber = allowedCharacters.isSuperset(of: characterSet)
        
        if isNumber {
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                let numericString = updatedText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                viewModel.updateAmount(Double(numericString) ?? 0)
            }
        }
        
        return false
    }
}
