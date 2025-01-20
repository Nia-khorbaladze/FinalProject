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
    
    // MARK: - Use Cases
    private(set) lazy var fetchCoinDetailUseCase: FetchCoinDetailUseCase = {
        FetchCoinDetailUseCase(repository: coinRepository)
    }()
    
    private(set) lazy var googleSignInUseCase: GoogleSignInUseCase = {
        GoogleSignInUseCase(repository: googleAuthRepository)
    }()
    
    // MARK: - View Models
    private(set) lazy var googleSignInViewModel: GoogleSignInViewModel = {
        GoogleSignInViewModel(googleSignInUseCase: googleSignInUseCase)
    }()
    
    private init() {
        self.coreDataService = CoreDataService()
        self.networkService = NetworkService()
    }
}
