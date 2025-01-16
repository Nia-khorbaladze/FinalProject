//
//  TabBarController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        let factory = ViewControllerFactory()
        
        let home = createTab(iconActive: TabBarIcons.homeSelected.rawValue,
                           iconInactive: TabBarIcons.home.rawValue,
                             vc: factory.makeHomePageViewController(),
                           identifier: "homeTab")
        
        let favorites = createTab(iconActive: TabBarIcons.favoritesSelected.rawValue,
                                iconInactive: TabBarIcons.favorites.rawValue,
                                  vc: factory.makeFavoritesPageViewController(),
                                identifier: "favoritesTab")
        
        let swap = createCentralTab(vc: factory.makeSwapPageViewController(), identifier: "swapTab")
        
        let portfolio = createTab(iconActive: TabBarIcons.portfolioSelected.rawValue,
                                iconInactive: TabBarIcons.portfolio.rawValue,
                                vc: PortfolioViewController(),
                                identifier: "portfolioTab")
        
        let search = createTab(iconActive: TabBarIcons.searchSelected.rawValue,
                             iconInactive: TabBarIcons.search.rawValue,
                             vc: SearchViewController(),
                             identifier: "searchTab")
        
        customizeTabBarAppearance()
        setViewControllers([home, favorites, swap, portfolio, search], animated: true)
    }
    
    private func createTab(iconActive: String, iconInactive: String, vc: UIViewController, identifier: String) -> UIViewController {
        let activeImage = UIImage(named: iconActive)?.withRenderingMode(.alwaysOriginal)
        let inactiveImage = UIImage(named: iconInactive)?.withRenderingMode(.alwaysOriginal)
        
        let resizedActiveImage = activeImage?.resized(to: CGSize(width: 30, height: 30))?.withRenderingMode(.alwaysOriginal)
        let resizedInactiveImage = inactiveImage?.resized(to: CGSize(width: 30, height: 30))?.withRenderingMode(.alwaysOriginal)
        
        let tabBarItem = UITabBarItem(title: nil,
                                    image: resizedInactiveImage,
                                    selectedImage: resizedActiveImage)
        
        tabBarItem.imageInsets = UIEdgeInsets(top: 12, left: 0, bottom: -12, right: 0)
        tabBarItem.accessibilityIdentifier = identifier
        vc.tabBarItem = tabBarItem
        
        return vc
    }
    
    private func createCentralTab(vc: UIViewController, identifier: String) -> UIViewController {
        let swapImage = UIImage(named: TabBarIcons.swap.rawValue)?.withRenderingMode(.alwaysOriginal)
        let resizedImage = swapImage?.resized(to: CGSize(width: 90, height: 90))?.withRenderingMode(.alwaysOriginal)
        
        let tabBarItem = UITabBarItem(title: nil,
                                    image: resizedImage,
                                    selectedImage: resizedImage)
        
        tabBarItem.imageInsets = UIEdgeInsets(top: 12, left: 0, bottom: -12, right: 0)
        tabBarItem.accessibilityIdentifier = identifier
        vc.tabBarItem = tabBarItem
        
        return vc
    }
    
    private func customizeTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(named: AppColors.greyBlue.rawValue)
        appearance.backgroundEffect = nil
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        tabBar.layer.borderWidth = 0
        tabBar.layer.borderColor = UIColor.clear.cgColor
        
        tabBar.itemPositioning = .centered
    }
}
