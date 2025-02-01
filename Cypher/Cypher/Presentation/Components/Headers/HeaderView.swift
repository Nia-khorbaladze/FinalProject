//
//  HeaderView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation
import UIKit

final class HeaderView: UIView {
    // MARK: - UI Elements
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = UIColor(named: AppColors.white.rawValue)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: AppColors.white.rawValue)
        label.font = Fonts.medium.uiFont(size: 18)
        return label
    }()
    
    // MARK: - Properties
    var onBackButtonTapped: (() -> Void)?
    
    // MARK: - Initializers
    init(title: String) {
        super.init(frame: .zero)
        setup(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup(title: String) {
        backgroundColor = UIColor(named: AppColors.darkGrey.rawValue)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backButton)
        addSubview(titleLabel)
        
        titleLabel.text = title
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        backButton.addAction(UIAction(handler: { [weak self] _ in
            self?.onBackButtonTapped?()
        }), for: .touchUpInside)
    }
}
