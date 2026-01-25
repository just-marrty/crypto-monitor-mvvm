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
                    Text(StringConstants.basicInfo)
                        .font(.system(size: 25, design: .rounded))
                        .bold()
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(StringConstants.name)
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    Text(cryptocurrency.name)
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(StringConstants.symbol)
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    Text(cryptocurrency.symbol)
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(StringConstants.price)
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    Text(cryptocurrency.usdPrice)
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(StringConstants.id)
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    Text(cryptocurrency.id)
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(StringConstants.rank)
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    Text("\(cryptocurrency.rank)")
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(StringConstants.totalSupply)
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    Text("\(cryptocurrency.totalSupply.formatted())")
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(StringConstants.maxSupply)
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    Text("\(cryptocurrency.maxSupply.formatted())")
                }
                .padding(.horizontal)
                
                Divider()

                
                VStack(alignment: .leading, spacing: 4) {
                    Text(StringConstants.firstDataAt)
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    Text(cryptocurrency.firstDataAt.formattedDateTime())
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(StringConstants.lastUpdated)
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
                        Image(systemName: StringConstants.chevronLeft)
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
