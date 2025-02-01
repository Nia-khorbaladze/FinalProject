//
//  EnterSendAmountViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import UIKit

final class EnterSendAmountViewController: UIViewController {
    private let coinSymbol: String
    private let walletAddress: String
    private let coinName: String
    private let imageURL: String
    private let viewModel: EnterSendAmountViewModel
    private var availableContainerBottomConstraint: NSLayoutConstraint!
    private var isErrorMessageVisible: Bool = false
    
    // MARK: - UI Elements
    private lazy var headerView: HeaderView = {
        let header = HeaderView(title: "Enter Amount")
        header.translatesAutoresizingMaskIntoConstraints = false
        header.onBackButtonTapped = { [weak self] in
            self?.navigateBack()
        }
        return header
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor(named: AppColors.lightGrey.rawValue), for: .normal)
        button.isEnabled = false
        button.titleLabel?.font = Fonts.semiBold.uiFont(size: 18)
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.navigateToSummaryPage()
        }), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var amountField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.font = Fonts.bold.uiFont(size: 48)
        textfield.textColor = UIColor(named: AppColors.white.rawValue)
        textfield.keyboardType = .decimalPad
        textfield.textAlignment = .center
        textfield.tintColor = .clear
        textfield.delegate = self

        textfield.placeholder = "0.00"
        
        textfield.attributedPlaceholder = NSAttributedString(
            string: "0.00",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: AppColors.lightGrey.rawValue)!]
        )
        
        return textfield
    }()
    
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.bold.uiFont(size: 48)
        label.textColor = UIColor(named: AppColors.white.rawValue)
        label.text = "\(coinSymbol)"
        
        return label
    }()
    
    private lazy var amountInputContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var availableContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var availableToSendLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Available to send"
        label.font = Fonts.medium.uiFont(size: 14)
        label.textColor = UIColor(named: AppColors.lightGrey.rawValue)
        
        return label
    }()
    
    private lazy var availableCoins: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.medium.uiFont(size: 18)
        label.textColor = UIColor(named: AppColors.white.rawValue)
        label.text = "0 \(coinSymbol)"
        
        return label
    }()
    
    private lazy var maxButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Max", for: .normal)
        button.backgroundColor = UIColor(named: AppColors.darkGrey.rawValue)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.handleMaxButtonTap()
        }), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: AppColors.lightGrey.rawValue)
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        return view
    }()
    
    private lazy var errorMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Insufficient funds"
        label.font = Fonts.bold.uiFont(size: 18)
        label.textColor = UIColor(named: AppColors.red.rawValue)
        
        return label
    }()
    
    // MARK: - Initializers
    init(coinSymbol: String, walletAddress: String, coinName: String, imageURL: String, viewModel: EnterSendAmountViewModel) {
        self.coinSymbol = coinSymbol
        self.walletAddress = walletAddress
        self.coinName = coinName
        self.imageURL = imageURL
        self.viewModel = viewModel
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
        updateUI()
        
        viewModel.onAmountUpdate = { [weak self] in
            self?.updateUI()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - UI Setup
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        setupUI()
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        view.addSubview(headerView)
        headerView.addSubview(nextButton)
        view.addSubview(amountInputContainer)
        amountInputContainer.addSubview(amountField)
        amountInputContainer.addSubview(symbolLabel)
        view.addSubview(availableContainer)
        availableContainer.addSubview(availableToSendLabel)
        availableContainer.addSubview(availableCoins)
        view.addSubview(maxButton)
        view.addSubview(bottomLine)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 55),
            
            nextButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            nextButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -13)
        ])
        
        NSLayoutConstraint.activate([
            amountInputContainer.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 40),
            amountInputContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            amountField.topAnchor.constraint(equalTo: amountInputContainer.topAnchor),
            amountField.leadingAnchor.constraint(equalTo: amountInputContainer.leadingAnchor),
            amountField.bottomAnchor.constraint(equalTo: amountInputContainer.bottomAnchor),
            amountField.trailingAnchor.constraint(equalTo: symbolLabel.leadingAnchor, constant: -5),
            symbolLabel.topAnchor.constraint(equalTo: amountInputContainer.topAnchor),
            symbolLabel.bottomAnchor.constraint(equalTo: amountInputContainer.bottomAnchor),
            symbolLabel.trailingAnchor.constraint(equalTo: amountInputContainer.trailingAnchor)
        ])
        
        availableContainerBottomConstraint = availableContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        
        NSLayoutConstraint.activate([
            availableContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            availableContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            availableContainerBottomConstraint,
            availableContainer.heightAnchor.constraint(equalToConstant: 60),
            
            availableToSendLabel.topAnchor.constraint(equalTo: availableContainer.topAnchor),
            availableToSendLabel.leadingAnchor.constraint(equalTo: availableContainer.leadingAnchor),
            
            availableCoins.topAnchor.constraint(equalTo: availableToSendLabel.bottomAnchor, constant: 5),
            availableCoins.leadingAnchor.constraint(equalTo: availableContainer.leadingAnchor),
            
            maxButton.trailingAnchor.constraint(equalTo: availableContainer.trailingAnchor),
            maxButton.topAnchor.constraint(equalTo: availableToSendLabel.topAnchor),
            maxButton.widthAnchor.constraint(equalToConstant: 60),
            maxButton.heightAnchor.constraint(equalToConstant: 40),
            
            bottomLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: availableContainer.topAnchor, constant: -10),
            bottomLine.heightAnchor.constraint(equalToConstant: 1)
        ])

    }
    
    private func addErrorMessageToView() {
        if errorMessage.superview == nil {
            view.addSubview(errorMessage)
            NSLayoutConstraint.activate([
                errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                errorMessage.topAnchor.constraint(equalTo: amountField.bottomAnchor, constant: 10)
            ])
        }
    }
    
    // MARK: - Functions
    private func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func updateUI() {
        guard let maxAmount = Double(viewModel.getAvailableAmount()) else { return }
        let isAmountValid = viewModel.amount > 0 && viewModel.amount <= maxAmount
        
        nextButton.isEnabled = isAmountValid
        nextButton.setTitleColor(
            isAmountValid ? UIColor(named: AppColors.accent.rawValue) : UIColor(named: AppColors.lightGrey.rawValue),
            for: .normal
        )
        
        availableCoins.text = "\(viewModel.getAvailableAmount()) \(coinSymbol)"
        
        if !(viewModel.amount <= maxAmount) {
            if !isErrorMessageVisible {
                addErrorMessageToView()
                isErrorMessageVisible = true
            }
        } else {
            if isErrorMessageVisible {
                removeErrorMessageFromView()
                isErrorMessageVisible = false
            }
        }
    }
    
    private func removeErrorMessageFromView() {
        errorMessage.removeFromSuperview()
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
        
        availableContainerBottomConstraint.constant = -offset
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    @objc private func keyboardWillHide(notification: NSNotification) {
        availableContainerBottomConstraint.constant = -5
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func handleMaxButtonTap() {
        guard let maxAmount = Double(viewModel.getAvailableAmount()) else { return }
        viewModel.updateAmount(maxAmount)
        amountField.text = viewModel.formatAmount()
    }
    
    private func navigateToSummaryPage() {
        let saveCoinsUseCase = Dependencies.shared.savePurchasedCoinUseCase
        
        let viewModel = SummaryViewModel(
            saveCoinsUseCase: saveCoinsUseCase,
            amount: viewModel.amount,
            coinSymbol: coinSymbol,
            coinName: coinName,
            imageURL: imageURL
        )
        
        let viewController = SummaryViewController(
            viewModel: viewModel,
            coinName: coinName,
            sendAmount: String(viewModel.amount),
            walletAddressString: walletAddress,
            coinSymbol: coinSymbol,
            imageURL: imageURL
        )
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Extensions
extension EnterSendAmountViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            return true
        }
        
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
        let characterSet = CharacterSet(charactersIn: string)
        let isNumber = allowedCharacters.isSuperset(of: characterSet)
        
        if isNumber {
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                
                let decimalCount = updatedText.components(separatedBy: ".").count - 1
                if decimalCount > 1 {
                    return false
                }
                
                if let amount = Double(updatedText) {
                    viewModel.updateAmount(amount)
                }
                
                textField.text = updatedText
            }
        }
        
        return false
    }
}


