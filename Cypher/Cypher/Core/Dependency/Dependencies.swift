//
//  Dependencies.swift
//  Cypher
//
//  Created by Nkhorbaladze on 19.01.25.
//

import Foundation

final class Dependencies {
    static let shared = Dependencies()
    
    // MARK: - Services
    let coreDataService: CoreDataServiceProtocol
    let networkService: NetworkServiceProtocol
    
    // MARK: - Repositories
    private(set) lazy var coinRepository: CoinRepositoryProtocol = {
        CoinRepository(
            networkService: networkService,
            coreDataService: coreDataService
        )
    }()
    
    private(set) lazy var googleAuthRepository: FirebaseGoogleAuthRepository = {
        FirebaseGoogleAuthRepository()
    }()

    private(set) lazy var purchasedCoinRepository: PurchasedCoinRepositoryProtocol = {
        PurchasedCoinRepository(coreDataService: coreDataService)
    }()
    
    private(set) lazy var favoriteCoinsRepository: FavoriteCoinsRepository = {
        FavoriteCoinsRepository(coreDataService: coreDataService)
    }()
    
    private(set) lazy var walletAddressRepository: WalletAddressRepository = {
        WalletAddressRepository()
    }()
    
    private(set) lazy var historyRepository: HistoryRepository = {
        HistoryRepository(networkService: networkService)
    }()
    
    private(set) lazy var usernameRepository: UsernameRepository = {
        UsernameRepository()
    }()
    
    // MARK: - Use Cases
    private(set) lazy var fetchCoinDetailUseCase: FetchCoinDetailUseCase = {
        FetchCoinDetailUseCase(repository: coinRepository)
    }()
    
    private(set) lazy var saveFavoriteCoinUseCase: SaveFavoriteCoinUseCase = {
        SaveFavoriteCoinUseCase(repository: favoriteCoinsRepository)
    }()
    
    private(set) lazy var removeFavoriteCoinUseCase: RemoveFavoriteCoinUseCase = {
        RemoveFavoriteCoinUseCase(repository: favoriteCoinsRepository)
    }()
    
    private(set) lazy var isFavoriteCoinUseCase: IsFavoriteCoinUseCase = {
        IsFavoriteCoinUseCase(repository: favoriteCoinsRepository)
    }()
    
    private(set) lazy var googleSignInUseCase: GoogleSignInUseCase = {
        GoogleSignInUseCase(repository: googleAuthRepository)
    }()
    
    private(set) lazy var savePurchasedCoinUseCase: SavePurchasedCoinUseCase = {
        SavePurchasedCoinUseCase(purchasedCoinRepository: purchasedCoinRepository)
    }()
    
    private(set) lazy var saveUsernameUseCase: SaveUsernameUseCase = {
        SaveUsernameUseCase(usernameRepository: usernameRepository)
    }()
    
    private let iconProvider = WalletIconProvider()
    
    private(set) lazy var walletAddressUseCase: WalletAddressUseCase = {
        WalletAddressUseCase(repository: walletAddressRepository, iconProvider: iconProvider)
    }()
    
    private(set) lazy var fetchPriceChangeUseCase = {
        FetchCoinPriceChangeUseCase(repository: historyRepository)
    }()

    private(set) lazy var logoutUseCase: LogoutUseCase = {
        LogoutUseCase()
    }()

    private(set) lazy var getUsernameUseCase: GetUsernameUseCase = {
        GetUsernameUseCase(usernameRepository: usernameRepository)
    }()

    
    // MARK: - View Models
    private(set) lazy var googleSignInViewModel: GoogleSignInViewModel = {
        GoogleSignInViewModel(googleSignInUseCase: googleSignInUseCase)
    }()
    
    func makeBuyCoinViewModel(coinSymbol: String, currentPrice: Double, imageURL: String, coinName: String) -> BuyCoinViewModel {
        BuyCoinViewModel(
            coinSymbol: coinSymbol,
            currentPrice: currentPrice,
            coinName: coinName,
            imageURL: imageURL,
            savePurchasedCoinUseCase: savePurchasedCoinUseCase
        )
    }
    
    func makeDetailsPageViewModel() -> DetailsPageViewModel {
        DetailsPageViewModel(
            fetchCoinDetailUseCase: fetchCoinDetailUseCase,
            fetchPriceChangeUseCase: fetchPriceChangeUseCase,
            saveFavoriteUseCase: saveFavoriteCoinUseCase,
            removeFavoriteUseCase: removeFavoriteCoinUseCase,
            isFavoriteUseCase: isFavoriteCoinUseCase
        )
    }
    
    func makeCreateUsernameViewModel() -> CreateUsernameViewModel {
        return CreateUsernameViewModel(saveUsernameUseCase: saveUsernameUseCase)
    }
    
    func makeProfilePopupViewModel() -> ProfilePopupViewModel {
        return ProfilePopupViewModel(
            logoutUseCase: logoutUseCase,
            getUsernameUseCase: getUsernameUseCase
        )
    }
    
    private init() {
        self.coreDataService = CoreDataService()
        self.networkService = NetworkService()
    }
}
