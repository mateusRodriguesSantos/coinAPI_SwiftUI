//
//  SybolHistoric.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 14/06/23.
//

import SwiftUI

struct SybolTrades: View {
    
    @EnvironmentObject var viewModel: ViewModel

    var symbolID: String = .empty
    var timeStart: String = .empty
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(3)
            } else {
                Text(symbolID)
                    .font(.subheadline)
                List {
                    ForEach(viewModel.trade) { historic in
                        TradeRow(
                            dataExchange: historic.timeExchange?.substring(10) ?? .empty,
                            price: String(format: "%.2f","\(historic.price ?? .zero)"),
                            size: "\(historic.size ?? .zero)",
                            isBuy: historic.takerSide == .buy ? true : false
                        )
                    }
                    
                }
            }
        }
        .navigationTitle("Trades")
        .onAppear {
            Task {
                viewModel.isLoading = true
                viewModel.historicalTradesData()
            }
        }
    }
}

struct SybolHistoric_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            let viewModel = ViewModel()
            SybolTrades()
                .environmentObject(viewModel)
                .onAppear {
                    viewModel.getMock()
                    viewModel.getMetadataSymbols(exchangeID: viewModel.listExchange.first?.exchangeID ?? .empty)
                    viewModel.historicalTradesData()
                }
        }
    }
}
