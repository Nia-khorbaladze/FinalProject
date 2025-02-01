//
//  ReceivePageViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 29.01.25.
//

import UIKit

final class ReceivePageViewController: UIViewController {
    private let viewModel: WalletViewModel
    private var walletData: [WalletData] = []
    
    // MARK: - UI Elements
    private lazy var coinsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AddressCell.self, forCellReuseIdentifier: AddressCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: AppColors.darkGrey.rawValue)
        
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
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
        label.text = "Receive"
        
        return label
    }()
    
    init(viewModel: WalletViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        loadWalletData()
    }
    
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        view.addSubview(headerView)
        view.addSubview(coinsTableView)
        headerView.addSubview(closeButton)
        headerView.addSubview(headerTitle)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            closeButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 13),
            closeButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 13),
            closeButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -13),
            
            headerTitle.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            coinsTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 13),
            coinsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coinsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coinsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadWalletData() {
        viewModel.walletAddresses = { [weak self] wallets in
            self?.walletData = wallets
            self?.coinsTableView.reloadData()
        }
        
        viewModel.errorMessage = { [weak self] _ in
            self?.showErrorAlert()
        }
        
        viewModel.fetchWalletData()
    }
    
    private func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extensions
extension ReceivePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return walletData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.identifier, for: indexPath) as? AddressCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let walletItem = walletData[indexPath.row]
        cell.configureCell(image: walletItem.iconImage, name: walletItem.coin, address: walletItem.address)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
