//
//  CryptoccurencyMainView.swift
//  CryptoMonitor
//
//  Created by Martin Hrbáček on 08.12.2025.
//

import SwiftUI

struct CryptoccurencyMainView: View {
    
    @State private var vm = CryptocurrencyListViewModel(fetchService: FetchService())
    
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
                            .foregroundStyle(.orange)
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
                                
                                Text(cryptocurrency.usdPrice.formatted(.currency(code: StringConstants.usd).presentation(.isoCode)))
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
