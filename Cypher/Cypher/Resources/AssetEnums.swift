//
//  AssetEnums.swift
//  Cypher
//
//  Created by Nkhorbaladze on 11.01.25.
//

import Foundation
import UIKit
import SwiftUI

public enum Icons: String {
    case welcomeImage = "WelcomeImage"
    case wallet = "Wallet"
    case wand = "magicWand"
    case shield = "shield"
    case recovery = "recovery"
    case successfulAuth = "SuccessfulAuth"
    case scan = "scan"
    case swap = "swap"
    case send = "send"
    case buy = "buy"
}

public enum AppColors: String {
    case backgroundColor = "BackgroundColor"
    case white = "WhiteText"
    case lightGrey = "LightGreyText"
    case accent = "AccentColor"
    case inactiveAccent = "InactiveAccentColor"
    case green = "AppGreen"
    case red = "AppRed"
    case greyBlue = "GreyBlue"
}

public enum Fonts: String {
    case medium = "Inter18pt-Medium"
    case regular = "Inter18pt-Regular"
    case semiBold = "Inter18pt-SemiBold"
    case bold = "Inter18pt-Bold"
    
    func size(_ size: CGFloat) -> Font {
        Font.custom(self.rawValue, size: size)
    }

    func uiFont(size: CGFloat) -> UIFont {
        UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

public enum TabBarIcons: String {
    case home = "home"
    case homeSelected = "homeSelected"
    case favorites = "favorites"
    case favoritesSelected = "favoritesSelected"
    case portfolio = "portfolio"
    case portfolioSelected = "portfolioSelected"
    case search = "search"
    case searchSelected = "searchSelected"
    case swap = "swapTabBar"
}
