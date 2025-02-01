//
//  SummaryViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 31.01.25.
//

import UIKit
import SwiftUI

final class SummaryViewController: UIViewController {
    private let coinName: String
    private let sendAmount: String
    private let walletAddressString: String
    private let coinSymbol: String
    private let imageURL: String
    private let viewModel: SummaryViewModel

    // MARK: - UI Elements
    private lazy var headerView: HeaderView = {
        let header = HeaderView(title: "Summary")
        header.translatesAutoresizingMaskIntoConstraints = false
        header.onBackButtonTapped = { [weak self] in
            self?.navigateBack()
        }
        return header
    }()
    
    private lazy var sendImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Icons.send.rawValue)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: AppColors.greyBlue.rawValue)
        view.widthAnchor.constraint(equalToConstant: 60).isActive = true
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        return view
    }()
    
    private lazy var sendAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.bold.uiFont(size: 48)
        label.textColor = UIColor(named: AppColors.white.rawValue)
        label.text = "\(sendAmount) \(coinSymbol)"
        
        return label
    }()
    
    private lazy var infoContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: AppColors.greyBlue.rawValue)
        view.heightAnchor.constraint(equalToConstant: 120).isActive = true
        view.layer.cornerRadius = 20

        return view
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        return view
    }()
    
    private lazy var toLabel: UILabel = createLabel(
        text: "To",
        textColor: UIColor(named: AppColors.lightGrey.rawValue) ?? .gray
    )
    
    private lazy var networkLabel: UILabel = createLabel(
        text: "Network",
        textColor: UIColor(named: AppColors.lightGrey.rawValue) ?? .gray
    )
    
    private lazy var walletAddress: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(walletAddressString)"
        label.textColor = UIColor(named: AppColors.white.rawValue)
        label.font = Fonts.medium.uiFont(size: 18)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingMiddle
        
        return label
    }()
    
    private lazy var networkNameLabel: UILabel = createLabel(
        text: "\(coinName)",
        textColor: UIColor(named: AppColors.white.rawValue) ?? .white
    )
    
    private lazy var sendButton: UIHostingController<PrimaryButton> = {
        let hostingController = UIHostingController(
            rootView: PrimaryButton(
                title: "Send",
                isActive: true,
                action: { [weak self] in
                    self?.handleSendTapped()
                }
            )
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    // MARK: - Initializers
    init(viewModel: SummaryViewModel, coinName: String, sendAmount: String, walletAddressString: String, coinSymbol: String, imageURL: String) {
        self.viewModel = viewModel
        self.coinName = coinName
        self.sendAmount = sendAmount
        self.walletAddressString = walletAddressString
        self.coinSymbol = coinSymbol
        self.imageURL = imageURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - UI Setup
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.addSubview(headerView)
        view.addSubview(circleView)
        circleView.addSubview(sendImageView)
        view.addSubview(sendAmountLabel)
        view.addSubview(infoContainer)
        infoContainer.addSubview(separator)
        infoContainer.addSubview(toLabel)
        infoContainer.addSubview(networkLabel)
        infoContainer.addSubview(walletAddress)
        infoContainer.addSubview(networkNameLabel)
        
        addChild(sendButton)
        view.addSubview(sendButton.view)
        sendButton.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 55),
        ])
        
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            sendImageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            sendImageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            sendImageView.widthAnchor.constraint(equalTo: circleView.widthAnchor, multiplier: 0.6),
            sendImageView.heightAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: 0.6)
        ])
        
        NSLayoutConstraint.activate([
            sendAmountLabel.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 50),
            sendAmountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            infoContainer.topAnchor.constraint(equalTo: sendAmountLabel.bottomAnchor, constant: 40),
            infoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            infoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            separator.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor),
            separator.centerYAnchor.constraint(equalTo: infoContainer.centerYAnchor),
            
            toLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 15),
            toLabel.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 15),
            toLabel.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -15),
            walletAddress.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -15),
            walletAddress.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 15),
            walletAddress.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -15),
            
            networkLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 15),
            networkLabel.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: -15),
            networkLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 15),
            networkNameLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -15),
            networkNameLabel.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: -15),
            networkNameLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            sendButton.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            sendButton.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            sendButton.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            sendButton.view.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.clipsToBounds = true
    }
    
    private func handleSendTapped() {
        Task {
            do {
                try await viewModel.sendCoins()
                DispatchQueue.main.async { [weak self] in
                    self?.navigationController?.pushViewController(SuccessfulTransactionViewController(), animated: true)
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.showErrorAlert(error: error)
                }
            }
        }
    }
    
    private func showErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: "Couldn't transfer coins. Please try again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func createLabel(text: String, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = textColor
        label.font = Fonts.medium.uiFont(size: 18)
        
        return label
    }
    
    private func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
}
