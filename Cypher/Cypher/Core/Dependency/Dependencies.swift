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
    private(set) lazy var fetchCoinDetailUseCase: FetchCoinDetailUseCaseProtocol = {
        FetchCoinDetailUseCase(repository: coinRepository)
    }()
    
    private(set) lazy var saveFavoriteCoinUseCase: SaveFavoriteCoinUseCaseProtocol = {
        SaveFavoriteCoinUseCase(repository: favoriteCoinsRepository)
    }()
    
    private(set) lazy var removeFavoriteCoinUseCase: RemoveFavoriteCoinUseCaseProtocol = {
        RemoveFavoriteCoinUseCase(repository: favoriteCoinsRepository)
    }()
    
    private(set) lazy var isFavoriteCoinUseCase: IsFavoriteCoinUseCaseProtocol = {
        IsFavoriteCoinUseCase(repository: favoriteCoinsRepository)
    }()
    
    private(set) lazy var googleSignInUseCase: GoogleSignInUseCaseProtocol = {
        GoogleSignInUseCase(repository: googleAuthRepository)
    }()
    
    private(set) lazy var savePurchasedCoinUseCase: SavePurchasedCoinUseCase = {
        SavePurchasedCoinUseCase(purchasedCoinRepository: purchasedCoinRepository)
    }()
    
    private(set) lazy var saveUsernameUseCase: SaveUsernameUseCaseProtocol = {
        SaveUsernameUseCase(usernameRepository: usernameRepository)
    }()
    
    private let iconProvider = WalletIconProvider()
    
    private(set) lazy var getWalletAddressUseCase: GetWalletAddressUseCaseProtocol = {
        GetWalletAddressUseCase(repository: walletAddressRepository, iconProvider: iconProvider)
    }()

    private(set) lazy var saveWalletAddressUseCase: SaveWalletAddressUseCaseProtocol = {
        SaveWalletAddressUseCase(repository: walletAddressRepository)
    }()
    
    private(set) lazy var fetchPriceChangeUseCase: FetchCoinPriceChangeUseCaseProtocol = {
        FetchCoinPriceChangeUseCase(repository: historyRepository)
    }()

    private(set) lazy var logoutUseCase: LogoutUseCaseProtocol = {
        LogoutUseCase()
    }()

    private(set) lazy var getUsernameUseCase: GetUsernameUseCaseProtocol = {
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
