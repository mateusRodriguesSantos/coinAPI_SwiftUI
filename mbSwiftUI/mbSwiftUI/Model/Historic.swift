//
//  Historic.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 14/06/23.
//

import Foundation

// MARK: - Welcome
struct Historic: Codable, Identifiable {
    var id: Int = UUID().hashValue
    let symbolID, timeExchange, timeCoinapi, uuid: String?
    let price, size: Double?
    let takerSide: TakerSide?

    enum CodingKeys: String, CodingKey {
        case symbolID = "symbol_id"
        case timeExchange = "time_exchange"
        case timeCoinapi = "time_coinapi"
        case uuid, price, size
        case takerSide = "taker_side"
    }
    
    public enum TakerSide: String, Codable {
        case buy = "BUY"
        case sell = "SELL"
        case unknown = "UNKNOWN"
    }
}
