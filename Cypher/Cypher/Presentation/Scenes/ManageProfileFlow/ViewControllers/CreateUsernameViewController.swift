//
//  CreateUsernameViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import UIKit
import SwiftUI

final class CreateUsernameViewController: UIViewController {
    private var buttonBottomConstraint: NSLayoutConstraint!
    private var isSaveButtonActive = false {
        didSet {
            updateSaveButton()
        }
    }
    
    // MARK: - UI Elements
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
        label.text = "Manage Profile"
        
        return label
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
                    
                }
            )
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        usernameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: - UI Setup
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.addSubview(usernameTextField)
        view.addSubview(headerView)
        headerView.addSubview(backButton)
        headerView.addSubview(headerTitle)
        
        addChild(saveButton)
        view.addSubview(saveButton.view)
        saveButton.didMove(toParent: self)
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
    
    private func updateSaveButton() {
        saveButton.rootView = PrimaryButton(
            title: "Next",
            isActive: isSaveButtonActive,
            action: {
                
            }
        )
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
