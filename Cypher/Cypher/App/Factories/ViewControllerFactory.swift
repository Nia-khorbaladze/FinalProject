//
//  ViewControllerFactory.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import UIKit

final class ViewControllerFactory {
    func makeHomePageViewController() -> UINavigationController {
        let networkService = NetworkService()
        let coinRepository = CoinRepository(networkService: networkService)
        let fetchCoinsUseCase = FetchCoinsUseCase(repository: coinRepository)
        let viewModel = CoinViewModel(fetchCoinsUseCase: fetchCoinsUseCase)
        let viewController = HomePageViewController(viewModel: viewModel)
        
        return UINavigationController(rootViewController: viewController)
    }
    
    func makeFavoritesPageViewController() -> UINavigationController {
        let viewModel = FavoritesViewModel()
        let viewController = FavoritesPageViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
    
    func makeSwapPageViewController() -> UINavigationController {
        let viewModel = SwapViewModel()
        let viewController = SwapPageViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
    
    func makePortfolioPageViewController() -> UINavigationController {
        let viewModel = PortfolioViewModel()
        let viewController = PortfolioViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
    
    func makeSearchPageViewController() -> UINavigationController {
        let viewModel = SearchViewModel()
        let viewController = SearchViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
}
