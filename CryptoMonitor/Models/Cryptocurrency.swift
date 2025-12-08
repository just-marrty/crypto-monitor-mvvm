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
    let firstDateAt: String?
    let lastUpdated: String
    let quotes: [String: Quote]
    
    struct Quote: Decodable, Hashable {
        let price: Double
    }
}
