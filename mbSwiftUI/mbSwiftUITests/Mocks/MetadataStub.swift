//
//  MetadataStub.swift
//  mbSwiftUITests
//
//  Created by Mateus Rodrigues on 15/06/23.
//

import Foundation
@testable import mbSwiftUI

class MetadataStub: MetadataProtocol {
    
    var isSuccess: Bool = false
    var paramGetSymbols: String = .empty
    
    let listExchange: [Exchange] = [
        Exchange(
            exchangeID: "AAC",
            name: "AAC",
            volume1DayUsd: 3.0,
            volume1hrs: 3.0,
            volume1month: 3.0,
            quoteStart: .empty,
            website: .empty,
            dataEnd: .empty,
            dataStart: .empty
        ),
        Exchange(
            exchangeID: "AAX",
            name: "AAX",
            volume1DayUsd: 3.0,
            volume1hrs: 3.0,
            volume1month: 3.0,
            quoteStart: .empty,
            website: .empty,
            dataEnd: .empty,
            dataStart: .empty
        )
    ]
    let exchangeDetail = Exchange(
        exchangeID: "AAX",
        name: "AAX",
        volume1DayUsd: 3.0,
        volume1hrs: 3.0,
        volume1month: 3.0,
        quoteStart: .empty,
        website: .empty,
        dataEnd: .empty,
        dataStart: .empty
    )
    
    let symbol = [
        Symbol(
            symbolID: "BTC-220114-52000-P",
            exchangeID: "AAX",
            symbolType: "OPTION",
            assetIDBase: "AAX",
            assetIDQuote: "USDT",
            assetIDUnit: "USDT",
            futureContractUnit: 3.0,
            futureContractUnitAsset: .empty,
            dataStart: .empty,
            dataEnd: .empty,
            dataQuoteStart: .empty,
            dataQuoteEnd: .empty,
            dataOrderbookStart: .empty,
            dataOrderbookEnd: .empty,
            dataTradeStart: .empty,
            dataTradeEnd: .empty,
            volume1Hrs: .zero,
            volume1HrsUsd: .zero,
            volume1Day: .zero,
            volume1DayUsd: .zero,
            volume1Mth: .zero,
            volume1MthUsd: .zero,
            price: .zero,
            symbolIDExchange: .empty,
            assetIDBaseExchange: .empty,
            assetIDQuoteExchange: .empty,
            pricePrecision: .zero,
            sizePrecision: .zero
        )
    ]
    
    func metadataExchanges(completionHandler: @escaping APIResponse<[Exchange]>) {
        if isSuccess {
            completionHandler(
                .success(
                    [
                        Exchange(
                            exchangeID: "AAX",
                            name: "AAX",
                            volume1DayUsd: 3.0,
                            volume1hrs: 3.0,
                            volume1month: 3.0,
                            quoteStart: .empty,
                            website: .empty,
                            dataEnd: .empty,
                            dataStart: .empty
                        )
                    ]
                )
            )
        } else {
            completionHandler(.failure(.invalidRequest))
        }
    }
    func metadataAssets(completionHandler: @escaping APIResponse<[Asset]>) {
        if isSuccess {
            completionHandler(
                .success(
                    [
                        Asset(
                            assetID: "OAX",
                            name: "AAX",
                            typeIsCrypto: .zero,
                            dataQuoteStart: .empty,
                            dataQuoteEnd: .empty,
                            dataOrderbookStart: .empty,
                            dataOrderbookEnd: .empty,
                            dataTradeStart: .empty,
                            dataTradeEnd: .empty,
                            dataSymbolsCount: .zero,
                            volume1HrsUsd: 4.0,
                            volume1DayUsd: 4.0,
                            volume1MthUsd: 4.0,
                            idIcon: .empty,
                            dataStart: .empty,
                            dataEnd: .empty
                        )
                    ]
                )
            )
        } else {
            completionHandler(.failure(.invalidRequest))
        }
    }
    func metadataSymbols(completionHandler: @escaping APIResponse<[Symbol]>) {
        if isSuccess {
            completionHandler(
                .success(
                    [
                        Symbol(
                            symbolID: "BINANCEOPTV_OPT_BTC_USDT_220128_38000_C",
                            exchangeID: "BINANCEOPTV",
                            symbolType: "OPTION",
                            assetIDBase: "BTC",
                            assetIDQuote: "USDT",
                            assetIDUnit: "USDT",
                            futureContractUnit: 3.0,
                            futureContractUnitAsset: .empty,
                            dataStart: .empty,
                            dataEnd: .empty,
                            dataQuoteStart: .empty,
                            dataQuoteEnd: .empty,
                            dataOrderbookStart: .empty,
                            dataOrderbookEnd: .empty,
                            dataTradeStart: .empty,
                            dataTradeEnd: .empty,
                            volume1Hrs: .zero,
                            volume1HrsUsd: .zero,
                            volume1Day: .zero,
                            volume1DayUsd: .zero,
                            volume1Mth: .zero,
                            volume1MthUsd: .zero,
                            price: .zero,
                            symbolIDExchange: .empty,
                            assetIDBaseExchange: .empty,
                            assetIDQuoteExchange: .empty,
                            pricePrecision: .zero,
                            sizePrecision: .zero
                        )
                    ]
                )
            )
        } else {
            completionHandler(.failure(.invalidRequest))
        }
    }
    func metadataSymbols(exchangeID: String, completionHandler: @escaping APIResponse<[Symbol]>) {
        paramGetSymbols = exchangeID
        if isSuccess {
            completionHandler(
                .success(
                    [
                        Symbol(
                            symbolID: "BTC-220114-52000-P",
                            exchangeID: "AAX",
                            symbolType: "OPTION",
                            assetIDBase: "AAX",
                            assetIDQuote: "USDT",
                            assetIDUnit: "USDT",
                            futureContractUnit: 3.0,
                            futureContractUnitAsset: .empty,
                            dataStart: .empty,
                            dataEnd: .empty,
                            dataQuoteStart: .empty,
                            dataQuoteEnd: .empty,
                            dataOrderbookStart: .empty,
                            dataOrderbookEnd: .empty,
                            dataTradeStart: .empty,
                            dataTradeEnd: .empty,
                            volume1Hrs: .zero,
                            volume1HrsUsd: .zero,
                            volume1Day: .zero,
                            volume1DayUsd: .zero,
                            volume1Mth: .zero,
                            volume1MthUsd: .zero,
                            price: .zero,
                            symbolIDExchange: .empty,
                            assetIDBaseExchange: .empty,
                            assetIDQuoteExchange: .empty,
                            pricePrecision: .zero,
                            sizePrecision: .zero
                        )
                    ]
                )
            )
        } else {
            completionHandler(.failure(.invalidRequest))
        }
    }
}
