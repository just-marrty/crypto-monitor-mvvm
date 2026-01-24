//
//  CryptocurrencyListViewModel.swift
//  CryptoMonitor
//
//  Created by Martin Hrbáček on 08.12.2025.
//

import Foundation
import Observation

@Observable
@MainActor
class CryptocurrencyListViewModel {
    var cryptocurrencies: [CryptocurrencyViewModel] = []
    var isLoading = false
    var errorMessage: String?
    
    let fetchService: FetchService
    
    init(fetchService: FetchService) {
        self.fetchService = fetchService
    }
    
    func loadCryptocurrency() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let cryptocurrencies = try await fetchService.fetchCryptocurrency()
            self.cryptocurrencies = cryptocurrencies.map(CryptocurrencyViewModel.init)
        } catch {
            errorMessage = StringConstants.errorMessage
        }
        
        isLoading = false
    }
    
    func search(for searchTerm: String) -> [CryptocurrencyViewModel] {
        if searchTerm.isEmpty {
            return cryptocurrencies
        } else {
            return cryptocurrencies.filter { cryptocurrency in
                cryptocurrency.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by rank: Bool) {
        if rank {
            cryptocurrencies.sort { $0.rank < $1.rank }
        } else {
            cryptocurrencies.sort { $0.rank > $1.rank }
        }
    }
}

struct CryptocurrencyViewModel: Identifiable, Hashable {
    
    private var cryptocurrency: Cryptocurrency
    
    init(cryptocurrency: Cryptocurrency) {
        self.cryptocurrency = cryptocurrency
    }
    
    var id: String {
        cryptocurrency.id
    }
    
    var name: String {
        cryptocurrency.name
    }
    
    var symbol: String {
        cryptocurrency.symbol
    }
    
    var rank: Int {
        cryptocurrency.rank
    }
    
    var totalSupply: Double {
        cryptocurrency.totalSupply
    }
    
    var maxSupply: Double {
        cryptocurrency.maxSupply
    }
    
    var firstDataAt: String {
        cryptocurrency.firstDataAt ?? "N/A"
    }
    
    var lastUpdated: String {
        cryptocurrency.lastUpdated
    }
    
    var usdPrice: Decimal {
        cryptocurrency.quotes.USD.price
    }
}
