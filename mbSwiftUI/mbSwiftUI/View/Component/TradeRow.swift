//
//  TradeRow.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 14/06/23.
//

import SwiftUI

struct TradeRow: View {
    
    var dataExchange: String = .empty
    var price: String = .empty
    var size: String = .empty
    var isBuy: Bool = false
    
    var body: some View {
        HStack {
            VStack {
                Text("Data \(dataExchange)")
                Text("Price \(price)")
                Text("Size \(size)")
            }
            Spacer()
            Text(isBuy ? "Buy" : "Sell")
                .foregroundColor(isBuy ? Color.green : Color.red)
        }
    }
}

struct Trade_Previews: PreviewProvider {
    static var previews: some View {
        TradeRow()
    }
}
