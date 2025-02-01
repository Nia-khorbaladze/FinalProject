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
        let viewModel = HomePageViewModel(
            fetchCoinsUseCase: dependencies.fetchCoinsUseCase,
            purchasedCoinUseCase: dependencies.fetchPurchasedCoinsUseCase,
            fetchCoinDetailUseCase: dependencies.fetchCoinDetailUseCase
        )
        let viewController = HomePageViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
    
    func makeFavoritesPageViewController() -> UINavigationController {
        let viewModel = FavoritesViewModel(
            fetchCoinsUseCase: dependencies.fetchCoinsUseCase,
            fetchFavoritesUseCase: dependencies.fetchFavoriteCoinsUseCase
        )
        let viewController = FavoritesPageViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
    
    func makeSwapPageViewController() -> UINavigationController {
        let viewModel = SwapViewModel(
            fetchCoinsUseCase: dependencies.fetchCoinsUseCase,
            getExchangeRateUseCase: dependencies.getExchangeRateUseCase,
            fetchPurchasedCoinsUseCase: dependencies.fetchPurchasedCoinsUseCase,
            swapCoinsUseCase: dependencies.swapCoinsUseCase
        )
        let viewController = SwapPageViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
    
    func makePortfolioPageViewController() -> UINavigationController {
        let viewModel = PortfolioViewModel(
            fetchCoinsUseCase: dependencies.fetchCoinsUseCase,
            fetchPurchasedCoinsUseCase: dependencies.fetchPurchasedCoinsUseCase
        )
        let viewController = PortfolioViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
    
    func makeSearchPageViewController() -> UINavigationController {
        let viewModel = CoinViewModel(fetchCoinsUseCase: dependencies.fetchCoinsUseCase)
        let viewController = SearchViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
    
    func makeDetailsPageViewController(coinName: String) -> DetailsPageViewController {
        let viewModel = dependencies.makeDetailsPageViewModel()
        let viewController = DetailsPageViewController(coinName: coinName, viewModel: viewModel)
        return viewController
    }

    func makeSelectCoinViewController() -> SelectCoinViewController {
        let viewModel = CoinViewModel(fetchCoinsUseCase: dependencies.fetchCoinsUseCase)
        return SelectCoinViewController(viewModel: viewModel)
    }
    
    func makeReceivePageViewController() -> ReceivePageViewController {
        let walletViewModel = WalletViewModel(walletAddressUseCase: dependencies.getWalletAddressUseCase)
        let viewController = ReceivePageViewController(viewModel: walletViewModel)
        return viewController
    }

    func makeChooseCoinToSendViewController() -> ChooseCoinToSendViewController {
        let viewModel = ChooseCoinViewModel(
            fetchPurchasedCoinsUseCase: dependencies.fetchPurchasedCoinsUseCase,
            fetchImagesUseCase: dependencies.fetchImagesUseCase
        )
        let viewController = ChooseCoinToSendViewController(viewModel: viewModel)
        return viewController
    }
}
