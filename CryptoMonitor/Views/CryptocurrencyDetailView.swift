//
//  CryptocurrencyDetailView.swift
//  CryptoMonitor
//
//  Created by Martin Hrbáček on 08.12.2025.
//

import SwiftUI

struct CryptocurrencyDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let cryptocurrency: CryptocurrencyViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack {
                    Text("Basic information")
                        .font(.system(size: 25, design: .rounded))
                        .bold()
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Name:")
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    Text(cryptocurrency.name)
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Symbol:")
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    Text(cryptocurrency.symbol)
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Price:")
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    Text(cryptocurrency.usdPrice.formatted(.currency(code: "USD").presentation(.isoCode)))
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("id:")
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    Text(cryptocurrency.id)
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Rank:")
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    Text("\(cryptocurrency.rank)")
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total supply")
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    Text("\(cryptocurrency.totalSupply.formatted())")
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Max supply")
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    Text("\(cryptocurrency.maxSupply.formatted())")
                }
                .padding(.horizontal)
                
                Divider()

                
                VStack(alignment: .leading, spacing: 4) {
                    Text("First data at:")
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    Text(cryptocurrency.firstDataAt.formattedDateTime())
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Last updated:")
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    Text(cryptocurrency.lastUpdated.formattedDateTime())
                }
                .padding(.horizontal)
            }
            .padding(.top, 25)
            .navigationTitle(cryptocurrency.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, design: .rounded))
                            .bold()
                    }
                }
            }
            .tint(.header)
        }
    }
}

#Preview {
    NavigationStack {
        CryptocurrencyDetailView(cryptocurrency: .sampleCryptocurrencyDetailView)
            .preferredColorScheme(.dark)
    }
}
