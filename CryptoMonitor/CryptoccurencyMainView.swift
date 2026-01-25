//
//  CryptoccurencyMainView.swift
//  CryptoMonitor
//
//  Created by Martin Hrbáček on 08.12.2025.
//

import SwiftUI

struct CryptoccurencyMainView: View {
    
    @State private var vm: CryptocurrencyListViewModel
    
    init(fetchService: FetchServiceProtocol = FetchService()) {
        _vm = State(wrappedValue: CryptocurrencyListViewModel(fetchService: fetchService))
    }
    
    @State private var searchText: String = ""
    @State private var rank: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack {
                if vm.isLoading {
                    ProgressView(StringConstants.loading)
                } else if let errorMessage = vm.errorMessage {
                    VStack {
                        Image(systemName: StringConstants.exclamationMarkTriangle)
                            .foregroundStyle(.header)
                            .bold()
                            .font(.system(size: 28, design: .rounded))
                        Text(StringConstants.oups)
                            .font(.system(size: 26, design: .rounded))
                            .bold()
                            .padding(5)
                        Text(errorMessage)
                            .font(.system(size: 22, design: .rounded))
                            .bold()
                            .padding(5)
                        Button {
                            Task {
                                await vm.loadCryptocurrency()
                            }
                        } label: {
                            VStack {
                                Text(StringConstants.tryAgain)
                                    .font(.system(size: 20, design: .rounded))
                                    .bold()
                                    .padding()
                                Image(systemName: StringConstants.arrowClockwise)
                                    .font(.system(size: 20, design: .rounded))
                                    .bold()
                            }
                        }
                    }
                    .multilineTextAlignment(.center)
                    .padding()
                } else {
                    List(vm.search(for: searchText)) { cryptocurrency in
                        NavigationLink(value: cryptocurrency) {
                            HStack {
                                Text(cryptocurrency.name)
                                    .font(.system(size: 18, design: .rounded))
                                    .bold()
                                Spacer()
                                
                                Text(cryptocurrency.usdPrice)
                                    .font(.system(size: 16, design: .rounded))
                            }
                        }
                    }
                    .navigationDestination(for: CryptocurrencyViewModel.self) { cryptocurrency in
                        CryptocurrencyDetailView(cryptocurrency: cryptocurrency)
                    }
                    .searchable(text: $searchText, prompt: StringConstants.searchCryptocurrency)
                    .animation(.default, value: searchText)
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task {
                            await vm.loadCryptocurrency()
                        }
                    } label: {
                        Image(systemName: StringConstants.arrowClockwise)
                            .font(.system(size: 18, design: .rounded))
                            .bold()
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        rank.toggle()
                        vm.sort(by: rank)
                    } label: {
                        Image(systemName: rank ? StringConstants.arrowDown : StringConstants.arrowUp)
                            .font(.system(size: 18, design: .rounded))
                            .bold()
                    }
                }
            }
            .navigationTitle(StringConstants.cryptocurrencies)
            .tint(.header)
        }
        .task {
            await vm.loadCryptocurrency()
        }
    }
}

#Preview {
    CryptoccurencyMainView()
        .preferredColorScheme(.dark)
}

#Preview("Mock Data") {
    struct MockService: FetchServiceProtocol {
        func fetchCryptocurrency() async throws -> [Cryptocurrency] {
            return [
                Cryptocurrency(
                    id: "btc-bitcoin",
                    name: "Bitcoin",
                    symbol: "BTC",
                    rank: 1,
                    totalSupply: 19959250,
                    maxSupply: 21000000,
                    firstDataAt: "2010-07-17T00:00:00Z",
                    lastUpdated: "2025-12-08T07:35:27Z",
                    quotes: Cryptocurrency.Quote(USD: Cryptocurrency.Quote.USD(price: 91726.981996402))
                )
            ]
        }
    }
    return CryptoccurencyMainView(fetchService: MockService())
        .preferredColorScheme(.dark)
}

#Preview("Status Code Error") {
    struct ErrorService: FetchServiceProtocol {
        func fetchCryptocurrency() async throws -> [Cryptocurrency] {
            throw NetworkError.httpError(404)
        }
    }
    return CryptoccurencyMainView(fetchService: ErrorService())
        .preferredColorScheme(.dark)
}
