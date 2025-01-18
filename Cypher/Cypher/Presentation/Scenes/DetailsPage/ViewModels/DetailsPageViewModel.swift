//
//  DetailsPageViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 18.01.25.
//

import Foundation
import Combine

final class DetailsPageViewModel: ObservableObject {
    private let repository: CoinRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var coinDetail: CoinDetailModel?
    @Published var isLoading: Bool = false
    @Published var error: String?
    @Published var isFavorited: Bool = false
    
    init(repository: CoinRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchCoinDetails(coinName: String) {
        isLoading = true
        
        repository.fetchCoinDetail(name: coinName)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                switch completion {
                case .failure(let error):
                    self.error = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] coinDetail in
                guard let self = self else { return }
                self.repository.saveCoinDetail(coinDetail)
                self.coinDetail = coinDetail
            }
            .store(in: &cancellables)
    }
    
    func cleanup() {
        cancellables.removeAll()
    }
    
    func toggleFavorite() {
        isFavorited.toggle()
    }
}


