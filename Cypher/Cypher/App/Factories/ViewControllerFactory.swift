//
//  ViewControllerFactory.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import UIKit

final class ViewControllerFactory {
    private let dependencies = Dependencies.shared

    func makeHomePageViewController() -> UINavigationController {
        let networkService = NetworkService()
        let coreDataService = CoreDataService()
        let coinRepository = CoinRepository(networkService: networkService, coreDataService: coreDataService)
        let imageRepository = ImageRepository()
        let fetchCoinsUseCase = FetchCoinsUseCase(coinRepository: coinRepository, imageRepository: imageRepository)
        let viewModel = CoinViewModel(fetchCoinsUseCase: fetchCoinsUseCase)
        let viewController = HomePageViewController(viewModel: viewModel)
        
        return UINavigationController(rootViewController: viewController)
    }
    
    func makeFavoritesPageViewController() -> UINavigationController {
        let networkService = NetworkService()
        let coreDataService = CoreDataService()
        let coinRepository = CoinRepository(networkService: networkService, coreDataService: coreDataService)
        let imageRepository = ImageRepository()
        let fetchImagesUseCase = FetchImagesUseCase(imageRepository: imageRepository)
        let favoriteCoinsRepository = dependencies.favoriteCoinsRepository
        let fetchFavoriteCoinsUseCase = FetchFavoritesUseCase(repository: favoriteCoinsRepository)
        let fetchCoinsUseCase = FetchCoinsUseCase(coinRepository: coinRepository, imageRepository: imageRepository)
        
        let viewModel = FavoritesViewModel(
            fetchCoinsUseCase: fetchCoinsUseCase,
            fetchFavoritesUseCase: fetchFavoriteCoinsUseCase,
            fetchImagesUseCase: fetchImagesUseCase
        )
        let viewController = FavoritesPageViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
    
    func makeSwapPageViewController() -> UINavigationController {
        let networkService = NetworkService()
        let coreDataService = CoreDataService()
        let coinRepository = CoinRepository(networkService: networkService, coreDataService: coreDataService)
        let imageRepository = ImageRepository()
        let fetchCoinsUseCase = FetchCoinsUseCase(coinRepository: coinRepository, imageRepository: imageRepository)

        let exchangeRateRepository = ExchangeRateRepository(networkService: networkService)

        let getExchangeRateUseCase = GetExchangeRateUseCase(repository: exchangeRateRepository)
        let purchasedCoinRepository = dependencies.purchasedCoinRepository
        let fetchPurchasedCoinUseCase = FetchPurchasedCoinsUseCase(purchasedCoinRepository: purchasedCoinRepository)
        
        let swapCoinsUseCase = SwapCoinsUseCase(getExchangeRateUseCase: getExchangeRateUseCase, repository: purchasedCoinRepository)
        
        let viewModel = SwapViewModel(fetchCoinsUseCase: fetchCoinsUseCase, getExchangeRateUseCase: getExchangeRateUseCase, fetchPurchasedCoinsUseCase: fetchPurchasedCoinUseCase, swapCoinsUseCase: swapCoinsUseCase)
        
        let viewController = SwapPageViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
    
    func makePortfolioPageViewController() -> UINavigationController {
        let networkService = NetworkService()
        let coreDataService = CoreDataService()
        let coinRepository = CoinRepository(networkService: networkService, coreDataService: coreDataService)
        let imageRepository = ImageRepository()
        let fetchImagesUseCase = FetchImagesUseCase(imageRepository: imageRepository)
        let purchasedCoinRepository = dependencies.purchasedCoinRepository
        let fetchPurchasedCoinUseCase = FetchPurchasedCoinsUseCase(purchasedCoinRepository: purchasedCoinRepository)
        let fetchCoinsUseCase = FetchCoinsUseCase(coinRepository: coinRepository, imageRepository: imageRepository)

        let viewModel = PortfolioViewModel(
            fetchCoinsUseCase: fetchCoinsUseCase,
            fetchPurchasedCoinsUseCase: fetchPurchasedCoinUseCase,
            fetchImagesUseCase: fetchImagesUseCase
        )

        let viewController = PortfolioViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
    
    func makeSearchPageViewController() -> UINavigationController {
        let networkService = NetworkService()
        let coreDataService = CoreDataService()
        let coinRepository = CoinRepository(networkService: networkService, coreDataService: coreDataService)
        let imageRepository = ImageRepository()
        let fetchCoinsUseCase = FetchCoinsUseCase(coinRepository: coinRepository, imageRepository: imageRepository)
        let viewModel = CoinViewModel(fetchCoinsUseCase: fetchCoinsUseCase)
        let viewController = SearchViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
    
    func makeDetailsPageViewController(coinName: String) -> DetailsPageViewController {
        let viewModel = dependencies.makeDetailsPageViewModel()
        let viewController = DetailsPageViewController(coinName: coinName, viewModel: viewModel)
        return viewController
    }

    func makeSelectCoinViewController() -> SelectCoinViewController {
        let fetchCoinsUseCase = FetchCoinsUseCase(
            coinRepository: dependencies.coinRepository,
            imageRepository: ImageRepository()
        )
        let viewModel = CoinViewModel(fetchCoinsUseCase: fetchCoinsUseCase)
        return SelectCoinViewController(viewModel: viewModel)
    }
    
    func makeReceivePageViewController() -> ReceivePageViewController {
        let WalletAddressRepository = WalletAddressRepository()
        let iconProvider = WalletIconProvider()
        let walletAddressUseCase = WalletAddressUseCase(repository: WalletAddressRepository, iconProvider: iconProvider)
        let walletViewModel = WalletViewModel(walletAddressUseCase: walletAddressUseCase)
        let viewController = ReceivePageViewController(viewModel: walletViewModel)
        return viewController
    }

    func makeChooseCoinToSendViewController() -> ChooseCoinToSendViewController {
        let viewController = ChooseCoinToSendViewController()
        
        return viewController
    }
}
