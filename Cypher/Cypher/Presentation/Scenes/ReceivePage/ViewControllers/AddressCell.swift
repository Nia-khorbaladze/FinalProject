//
//  AddressCell.swift
//  Cypher
//
//  Created by Nkhorbaladze on 29.01.25.
//

import UIKit

import UIKit

final class AddressCell: UITableViewCell {
    static let identifier = "AddressCell"
    
    // MARK: - UI Elements
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: AppColors.greyBlue.rawValue)
        view.layer.cornerRadius = 12
        
        return view
    }()

    private lazy var coinIconContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var coinIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var coinName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.medium.uiFont(size: 16)
        label.textColor = UIColor(named: AppColors.white.rawValue)
        
        return label
    }()
    
    private lazy var walletAddress: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.medium.uiFont(size: 13)
        label.textColor = UIColor(named: AppColors.lightGrey.rawValue)
        label.textAlignment = .right
        label.lineBreakMode = .byTruncatingMiddle
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: Icons.copy.rawValue), for: .normal)
        
        return button
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        view.heightAnchor.constraint(equalToConstant: 10).isActive = true
        return view
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(coinIconContainer)
        coinIconContainer.addSubview(coinIcon)
        containerView.addSubview(coinName)
        containerView.addSubview(walletAddress)
        containerView.addSubview(copyButton)
        contentView.addSubview(separatorView)
        
        copyButton.addTarget(self, action: #selector(copyToClipboard), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            coinIconContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            coinIconContainer.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            coinIconContainer.widthAnchor.constraint(equalToConstant: 40),
            coinIconContainer.heightAnchor.constraint(equalToConstant: 40),
            
            coinIcon.centerXAnchor.constraint(equalTo: coinIconContainer.centerXAnchor),
            coinIcon.centerYAnchor.constraint(equalTo: coinIconContainer.centerYAnchor),
            coinIcon.widthAnchor.constraint(equalToConstant: 24),
            coinIcon.heightAnchor.constraint(equalToConstant: 24),
            
            coinName.leadingAnchor.constraint(equalTo: coinIconContainer.trailingAnchor, constant: 12),
            coinName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            
            walletAddress.leadingAnchor.constraint(equalTo: coinIconContainer.trailingAnchor, constant: 12),
            walletAddress.topAnchor.constraint(equalTo: coinName.bottomAnchor, constant: 2),
            walletAddress.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            walletAddress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -110),
            
            copyButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            copyButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            copyButton.widthAnchor.constraint(equalToConstant: 18),
            copyButton.heightAnchor.constraint(equalToConstant: 18),
            
            separatorView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc private func copyToClipboard() {
        UIPasteboard.general.string = walletAddress.text
    }
    
    // MARK: - Configure Cell
    func configureCell(image: UIImage?, name: String, address: String) {
        if let image = image {
            coinIcon.image = image
        } else {
            coinIcon.image = UIImage(systemName: "circle")
        }
        coinName.text = name
        walletAddress.text = address
    }

}
