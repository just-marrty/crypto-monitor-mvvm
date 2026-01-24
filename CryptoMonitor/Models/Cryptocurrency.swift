//
//  Cryptocurrency.swift
//  CryptoMonitor
//
//  Created by Martin Hrbáček on 08.12.2025.
//

import Foundation

struct Cryptocurrency: Decodable, Hashable {
    let id: String
    let name: String
    let symbol: String
    let rank: Int
    let totalSupply: Double
    let maxSupply: Double
    let firstDataAt: String?
    let lastUpdated: String
    let quotes: Quote
    
    struct Quote: Decodable, Hashable {
        let USD: USD
        
        struct USD: Decodable, Hashable {
            let price: Decimal
        }
    }
}
