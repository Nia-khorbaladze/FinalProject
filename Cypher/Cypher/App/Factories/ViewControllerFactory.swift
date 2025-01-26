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
        let viewModel = FavoritesViewModel()
        let viewController = FavoritesPageViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
    
    func makeSwapPageViewController() -> UINavigationController {
        let networkService = NetworkService()
        let coreDataService = CoreDataService()
        let coinRepository = CoinRepository(networkService: networkService, coreDataService: coreDataService)
        let imageRepository = ImageRepository()
        let fetchCoinsUseCase = FetchCoinsUseCase(coinRepository: coinRepository, imageRepository: imageRepository)

        let viewModel = SwapViewModel(fetchCoinsUseCase: fetchCoinsUseCase)
        let viewController = SwapPageViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
    
    func makePortfolioPageViewController() -> UINavigationController {
        let networkService = NetworkService()
        let coreDataService = CoreDataService()
        let coinRepository = CoinRepository(networkService: networkService, coreDataService: coreDataService)
        let imageRepository = ImageRepository()
        let purchasedCoinRepository = PurchasedCoinRepository()
        let fetchCoinsUseCase = FetchCoinsUseCase(coinRepository: coinRepository, imageRepository: imageRepository)

        let viewModel = PortfolioViewModel(
            fetchCoinsUseCase: fetchCoinsUseCase,
            purchasedCoinRepository: purchasedCoinRepository,
            imageRepository: imageRepository
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
}
