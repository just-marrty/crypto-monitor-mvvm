//
//  FetchServiceProtocol.swift
//  CryptoMonitor
//
//  Created by Martin Hrbáček on 25.01.2026.
//

import Foundation

protocol FetchServiceProtocol: Sendable {
    func fetchCryptocurrency() async throws -> [Cryptocurrency]
}
