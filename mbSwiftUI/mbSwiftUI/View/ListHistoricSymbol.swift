//
//  ListHistoricSymbol.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 14/06/23.
//

import SwiftUI

struct ListHistoricSymbol: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var exchangeID: String = .empty
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(3)
            } else {
                List {
                    ForEach(viewModel.listSymbol) { symbol in
                        NavigationLink {
                            SybolTrades(symbolID: symbol.symbolID ?? .empty, timeStart: symbol.dataQuoteStart ?? .empty)
                        } label: {
                            RowHistoric(
                                text: "\(symbol.assetIDBase ?? .empty) -> \(symbol.assetIDQuote ?? .empty) ",
                                type: symbol.symbolType ?? .empty
                            )
                        }
                    }
                }
            }
        }
        .navigationTitle("Symbols")
        .onAppear {
            Task {
                viewModel.isLoading = true
                viewModel.getMetadataSymbols(exchangeID: exchangeID)
            }
        }
    }
}

struct ListHistoricSymbol_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            let viewModel = ViewModel()
            ListHistoricSymbol()
                .environmentObject(viewModel)
                .onAppear {
                    viewModel.getMock()
                    viewModel.getMetadataSymbols(exchangeID: viewModel.listExchange.first?.exchangeID ?? .empty)
                }
        }
    }
}
