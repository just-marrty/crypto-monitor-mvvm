//
//  ContentView.swift
//  CryptoMonitor
//
//  Created by Martin Hrbáček on 08.12.2025.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isDarkOn") private var isDarkOn: Bool = false
    
    @State private var vm = CryptocurrencyListViewModel(fetchService: FetchService())
    
    @State private var searchText: String = ""
    @State private var rank: Bool = true
    
    var body: some View {
        Group {
            if vm.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = vm.errorMessage {
                VStack {
                    Text("Error")
                        .font(.headline)
                    Text(errorMessage)
                        .foregroundColor(.secondary)
                    Button("Try again") {
                        Task {
                            await vm.loadCryptocurrency()
                        }
                    }
                }
            } else {
                NavigationStack {
                    List(vm.search(for: searchText)) { cryptocurrency in
                        NavigationLink(value: cryptocurrency) {
                            HStack {
                                Text(cryptocurrency.name)
                                    .font(.system(size: 18))
                                    .bold()
                                Spacer()
                                
                                Text("\(cryptocurrency.usdPrice) USD")
                                    .font(.system(size: 16))
                            }
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Cryptocurrencies")
                    .toolbarBackgroundVisibility(.visible, for: .navigationBar)
                    .toolbarBackground(.header)
                    
                    .navigationDestination(for: CryptocurrencyViewModel.self) { cryptocurrency in
                        // CryptocurrencyDetailView
                        CryptocurrencyDetailView(cryptocurrency: cryptocurrency)
                    }
                    .searchable(text: $searchText, prompt: "Search cryptocurrency")
                    .animation(.default, value: searchText)
                    
                    .navigationBarItems(trailing: Button(action: {
                        isDarkOn.toggle()
                    }, label: {
                        Image(systemName: isDarkOn ? "moon.fill" : "sun.max.fill")
                            .font(.system(size: 18))
                    }))
                    
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                rank.toggle()
                                vm.sort(by: rank)
                            } label: {
                                Image(systemName: rank ? "arrow.down" : "arrow.up")
                                    .bold()
                            }
                        }
                    }
                    
                    .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            Button("Refresh") {
                                Task {
                                    await vm.loadCryptocurrency()
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .foregroundStyle(isDarkOn ? .white : .white)
                            .tint(isDarkOn ? .header : .black)
                        }
                    }
                }
            }
        }
        .preferredColorScheme(isDarkOn ? .dark : .light)
        .tint(isDarkOn ? .white : .primary)
        .task {
            await vm.loadCryptocurrency()
        }
    }
}

#Preview {
    ContentView()
}
