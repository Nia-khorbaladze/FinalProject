//
//  SendCoinCell.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import UIKit

final class SendCoinCell: UITableViewCell {
    static let identifier = "SendCoinCell"
    
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
    
    private lazy var coinAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.medium.uiFont(size: 13)
        label.textColor = UIColor(named: AppColors.lightGrey.rawValue)
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingMiddle
        label.numberOfLines = 1
        
        return label
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
        containerView.addSubview(coinAmountLabel)
        contentView.addSubview(separatorView)
                
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
            
            coinAmountLabel.leadingAnchor.constraint(equalTo: coinIconContainer.trailingAnchor, constant: 12),
            coinAmountLabel.topAnchor.constraint(equalTo: coinName.bottomAnchor, constant: 2),
            coinAmountLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            coinAmountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -110),
            
            separatorView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Configure Cell
    func configureCell(image: UIImage?, name: String, amount: String) {
        if let image = image {
            coinIcon.image = image
        } else {
            coinIcon.image = UIImage(systemName: "circle")
        }
        coinName.text = name
        coinAmountLabel.text = amount
    }

}
