//
//  ChooseCoinToSendViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import UIKit

final class ChooseCoinToSendViewController: UIViewController {
    private let viewModel: ChooseCoinViewModel
    private var coins: [SendableCoin] = []
    
    private lazy var purchasedCoinsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SendCoinCell.self, forCellReuseIdentifier: SendCoinCell.identifier)
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
        label.text = "Select Coin"
        
        return label
    }()
    
    init(viewModel: ChooseCoinViewModel) {
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
        loadData()
    }
    
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        view.addSubview(headerView)
        view.addSubview(purchasedCoinsTableView)
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
            
            purchasedCoinsTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 13),
            purchasedCoinsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            purchasedCoinsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            purchasedCoinsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func loadData() {
        viewModel.didUpdateCoins = { [weak self] updatedCoins in
            self?.coins = updatedCoins
            self?.purchasedCoinsTableView.reloadData()
        }
        viewModel.fetchCoins()
    }
}

// MARK: - Extensions
extension ChooseCoinToSendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SendCoinCell.identifier, for: indexPath) as? SendCoinCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        let coin = coins[indexPath.row]
        cell.configureCell(image: coin.image, name: coin.name, amount: "\(coin.totalAmount)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let coin = coins[indexPath.row]
        let addressInputVC = AddressInputViewController(coinSymbol: coin.symbol)
        navigationController?.pushViewController(addressInputVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

