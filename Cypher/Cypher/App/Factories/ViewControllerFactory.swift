//
//  ViewControllerFactory.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import UIKit

final class ViewControllerFactory {
    func makeHomePageViewController() -> UIViewController {
        let viewModel = HomePageViewModel()
        return HomePageViewController(viewModel: viewModel)
    }
    
    func makeFavoritesPageViewController() -> UIViewController {
        let viewModel = HomePageViewModel()
        return FavoritesPageViewController(viewModel: viewModel)
    }
    
    func makeSwapPageViewController() -> UIViewController {
        let viewModel = SwapViewModel()
        return SwapPageViewController(viewModel: viewModel)
    }
}
