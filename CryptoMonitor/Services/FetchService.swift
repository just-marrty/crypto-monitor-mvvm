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
    case httpError(Int)
    case decodingFail
}

struct FetchService {
        
    func fetchCryptocurrency() async throws -> [Cryptocurrency] {
        guard let url = URL(string: APIConstants.baseURL+APIConstants.endpoints) else {
            print("Invalid URL")
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("HTTP Response Error")
            throw NetworkError.badResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            print("Status Code Error: \(httpResponse.statusCode)")
            throw NetworkError.httpError(httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Cryptocurrency].self, from: data)
        } catch {
            print("Decoding error: \(error)")
            throw NetworkError.decodingFail
        }
    }
}
