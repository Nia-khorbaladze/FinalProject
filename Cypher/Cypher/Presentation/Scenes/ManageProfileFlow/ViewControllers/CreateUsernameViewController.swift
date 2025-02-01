//
//  CreateUsernameViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import UIKit
import SwiftUI

final class CreateUsernameViewController: UIViewController {
    private let viewModel: CreateUsernameViewModel
    private var buttonBottomConstraint: NSLayoutConstraint!
    private var isSaveButtonActive = false {
        didSet {
            updateSaveButton()
        }
    }
    private var keyboardHandler: KeyboardHandler?
    
    // MARK: - UI Elements
    private lazy var headerView: HeaderView = {
        let header = HeaderView(title: "Create Username")
        header.translatesAutoresizingMaskIntoConstraints = false
        header.onBackButtonTapped = { [weak self] in
            self?.navigateBack()
        }
        return header
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "@username"
        textField.textColor = UIColor(named: AppColors.white.rawValue)
        textField.delegate = self
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(named: AppColors.greyBlue.rawValue)
        textField.layer.cornerRadius = 25
        textField.layer.masksToBounds = true
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        if let placeholder = textField.placeholder {
            textField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [.foregroundColor: UIColor(named: AppColors.lightGrey.rawValue) ?? .lightGray]
            )
        }
        
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        return textField
    }()
    
    private lazy var saveButton: UIHostingController<PrimaryButton> = {
        let hostingController = UIHostingController(
            rootView: PrimaryButton(
                title: "Save",
                isActive: isSaveButtonActive,
                action: { [weak self] in
                    self?.saveUsername()
                }
            )
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    init(viewModel: CreateUsernameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        keyboardHandler = nil
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        usernameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    // MARK: - Setup
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        setupUI()
        setupConstraints()
        
        keyboardHandler = KeyboardHandler(view: view, bottomConstraint: buttonBottomConstraint, bottomOffset: 20)
    }
    
    private func setupUI() {
        view.addSubview(usernameTextField)
        view.addSubview(headerView)
        
        addChild(saveButton)
        view.addSubview(saveButton.view)
        saveButton.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 55),
            
            usernameTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 35),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -13),
            usernameTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        buttonBottomConstraint = saveButton.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        NSLayoutConstraint.activate([
            buttonBottomConstraint,
            saveButton.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.view.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Functions
    private func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func textFieldDidBeginEditing() {
        if usernameTextField.text?.isEmpty ?? true {
            usernameTextField.text = "@"
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        isSaveButtonActive = !(textField.text?.isEmpty ?? true)
    }
    
    private func updateSaveButton() {
        saveButton.rootView = PrimaryButton(
            title: "Next",
            isActive: isSaveButtonActive,
            action: { [weak self] in
                self?.saveUsername()
            }
        )
    }
    
    private func saveUsername() {
        guard let username = usernameTextField.text, !username.isEmpty else {
            return
        }
        
        Task { [weak self] in
            do {
                try await self?.viewModel.saveUsername(username: username)
                DispatchQueue.main.async {
                    self?.navigateToSuccessPage()
                }
            } catch {
                print("Failed to save username: \(error.localizedDescription)")
            }
        }
    }
    
    private func navigateToSuccessPage() {
        let viewController = SuccessfulUsernameChangeViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Extensions
extension CreateUsernameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        if text.isEmpty && string != "@" {
            textField.text = "@"
            return false
        }
        
        if text.first == "@" {
            return true
        }
        
        return true
    }
}
