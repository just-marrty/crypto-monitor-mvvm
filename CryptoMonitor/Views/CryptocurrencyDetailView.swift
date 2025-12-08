//
//  CryptocurrencyDetailView.swift
//  CryptoMonitor
//
//  Created by Martin Hrbáček on 08.12.2025.
//

import SwiftUI

struct CryptocurrencyDetailView: View {
    
    @AppStorage("isDarkOn") private var isDarkOn: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    let cryptocurrency: CryptocurrencyViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack {
                    Text("Basic information")
                        .font(.system(size: 25))
                        .bold()
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Name:")
                        .font(.system(size: 18))
                        .bold()
                    Text(cryptocurrency.name)
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Symbol:")
                        .font(.system(size: 18))
                        .bold()
                    Text(cryptocurrency.symbol)
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Price:")
                        .font(.system(size: 18))
                        .bold()
                    Text("\(cryptocurrency.usdPrice) USD")
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("id:")
                        .font(.system(size: 18))
                        .bold()
                    Text(cryptocurrency.id)
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Rank:")
                        .font(.system(size: 18))
                        .bold()
                    Text("\(cryptocurrency.rank)")
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total supply")
                        .font(.system(size: 18))
                        .bold()
                    Text("\(cryptocurrency.totalSupply)")
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("First date at:")
                        .font(.system(size: 18))
                        .bold()
                    Text(cryptocurrency.firstDateAt)
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Last updated:")
                        .font(.system(size: 18))
                        .bold()
                    Text(cryptocurrency.lastUpdated)
                }
                .padding(.horizontal)
            }
            .padding(.top, 25)
            .navigationTitle(cryptocurrency.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbarBackground(.header)
            .navigationBarBackButtonHidden(true)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CryptocurrencyDetailView(cryptocurrency: .sampleCryptocurrencyDetailView)
    }
}
