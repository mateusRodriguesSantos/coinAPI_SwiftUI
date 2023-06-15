//
//  Symbol.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 13/06/23.
//

import Foundation

// MARK: - Symbol
struct Symbol: Codable, Identifiable {
    var id: Int = UUID().hashValue
    let symbolID, exchangeID, symbolType, assetIDBase: String?
    let assetIDQuote, assetIDUnit: String?
    let futureContractUnit: Double?
    let futureContractUnitAsset, dataStart, dataEnd, dataQuoteStart: String?
    let dataQuoteEnd, dataOrderbookStart, dataOrderbookEnd, dataTradeStart: String?
    let dataTradeEnd: String?
    let volume1Hrs, volume1HrsUsd, volume1Day, volume1DayUsd: Double?
    let volume1Mth, volume1MthUsd, price: Double?
    let symbolIDExchange, assetIDBaseExchange, assetIDQuoteExchange: String?
    let pricePrecision: Double?
    let sizePrecision: Double?

    enum CodingKeys: String, CodingKey {
        case symbolID = "symbol_id"
        case exchangeID = "exchange_id"
        case symbolType = "symbol_type"
        case assetIDBase = "asset_id_base"
        case assetIDQuote = "asset_id_quote"
        case assetIDUnit = "asset_id_unit"
        case futureContractUnit = "future_contract_unit"
        case futureContractUnitAsset = "future_contract_unit_asset"
        case dataStart = "data_start"
        case dataEnd = "data_end"
        case dataQuoteStart = "data_quote_start"
        case dataQuoteEnd = "data_quote_end"
        case dataOrderbookStart = "data_orderbook_start"
        case dataOrderbookEnd = "data_orderbook_end"
        case dataTradeStart = "data_trade_start"
        case dataTradeEnd = "data_trade_end"
        case volume1Hrs = "volume_1hrs"
        case volume1HrsUsd = "volume_1hrs_usd"
        case volume1Day = "volume_1day"
        case volume1DayUsd = "volume_1day_usd"
        case volume1Mth = "volume_1mth"
        case volume1MthUsd = "volume_1mth_usd"
        case price
        case symbolIDExchange = "symbol_id_exchange"
        case assetIDBaseExchange = "asset_id_base_exchange"
        case assetIDQuoteExchange = "asset_id_quote_exchange"
        case pricePrecision = "price_precision"
        case sizePrecision = "size_precision"
    }
}
