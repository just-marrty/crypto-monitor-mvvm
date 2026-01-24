//
//  FetchService.swift
//  CryptoMonitor
//
//  Created by Martin Hrbáček on 08.12.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case badResponse
}

struct FetchService {
    
    private let endpoints = "/tickers"
    
    private let baseURL = "https://api.coinpaprika.com/v1"
    
    func fetchCryptocurrency() async throws -> [Cryptocurrency] {
        guard let url = URL(string: baseURL+endpoints) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode([Cryptocurrency].self, from: data)
    }
}
