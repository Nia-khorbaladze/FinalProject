//
//  AddressInputViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import UIKit
import SwiftUI

final class AddressInputViewController: UIViewController {
    private let coinSymbol: String
    private let coinName: String
    private var isNextButtonActive = false {
        didSet {
            updateNextButton()
        }
    }
    private var buttonBottomConstraint: NSLayoutConstraint!
    private let availableAmount: Double
    private let imageURL: String
    
    // MARK: - UI Elements
    private lazy var headerView: HeaderView = {
        let header = HeaderView(title: "Send \(coinSymbol)")
        header.translatesAutoresizingMaskIntoConstraints = false
        header.onBackButtonTapped = { [weak self] in
            self?.navigateBack()
        }
        return header
    }()
    
    private lazy var addressInputField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter address"
        textField.textColor = UIColor(named: AppColors.white.rawValue)
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
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
    
    private lazy var nextButton: UIHostingController<PrimaryButton> = {
        let hostingController = UIHostingController(
            rootView: PrimaryButton(
                title: "Buy",
                isActive: isNextButtonActive,
                action: { }
            )
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    // MARK: - Initializers
    init(coinSymbol: String, coinName: String, availableAmount: Double, imageURL: String) {
        self.coinSymbol = coinSymbol
        self.coinName = coinName
        self.availableAmount = availableAmount
        self.imageURL = imageURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - UISetup
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        setupUI()
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        view.addSubview(headerView)
        view.addSubview(addressInputField)
        view.addSubview(bottomLine)
        
        addChild(nextButton)
        view.addSubview(nextButton.view)
        nextButton.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 55),
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
        
        buttonBottomConstraint = nextButton.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        NSLayoutConstraint.activate([
            buttonBottomConstraint,
            nextButton.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextButton.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.view.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Functions
    private func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        isNextButtonActive = !(textField.text?.isEmpty ?? true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardFrameInView = view.convert(keyboardFrame, from: nil)
        let keyboardTop = keyboardFrameInView.minY
        let safeAreaBottom = view.safeAreaLayoutGuide.layoutFrame.maxY
        let offset = safeAreaBottom - keyboardTop
        
        buttonBottomConstraint.constant = -(offset + 20)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        buttonBottomConstraint.constant = -20
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func updateNextButton() {
        nextButton.rootView = PrimaryButton(
            title: "Next",
            isActive: isNextButtonActive,
            action: { [weak self] in
                self?.navigateToAmountInputPage()
            }
        )
    }
    
    private func navigateToAmountInputPage() {
        guard let walletAddress = addressInputField.text, !walletAddress.isEmpty else {
            return
        }
        
        let viewModel = EnterSendAmountViewModel(availableAmount: availableAmount)
        let enterAmountVC = EnterSendAmountViewController(
            coinSymbol: coinSymbol,
            walletAddress: walletAddress,
            coinName: coinName,
            imageURL: imageURL,
            viewModel: viewModel
        )
        
        navigationController?.pushViewController(enterAmountVC, animated: true)
    }
}
