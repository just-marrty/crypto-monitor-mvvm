//
//  SampleCryptocurrencyDetailView.swift
//  CryptoMonitor
//
//  Created by Martin Hrbáček on 08.12.2025.
//

import SwiftUI

extension CryptocurrencyViewModel {
    static let sampleCryptocurrencyDetailView = CryptocurrencyViewModel(cryptocurrency: Cryptocurrency(
            id: "btc-bitcoin",
            name: "Bitcoin",
            symbol: "BTC",
            rank: 1,
            totalSupply: 19959250,
            maxSupply: 21000000,
            firstDateAt: "2010-07-17T00:00:00Z",
            lastUpdated: "2025-12-08T07:35:27Z",
            quotes: [
                "USD": Cryptocurrency.Quote(price: 91726.98)
            ]
        )
    )
}
