//
//  TradesDataStub.swift
//  mbSwiftUITests
//
//  Created by Mateus Rodrigues on 15/06/23.
//

import Foundation
@testable import mbSwiftUI

class TradesDataStub: TradesDataProtocol {
    
    var isSuccess: Bool = false
    
    func latestTradesData(symbol id: String, limit: Int, completionHandler: @escaping APIResponse<String>) {
        if isSuccess {
            completionHandler(.success("nothing"))
        } else {
            completionHandler(.failure(.invalidRequest))
        }
    }
    
    func historicalTradesData(symbol id: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping APIResponse<[Historic]>) {
        if isSuccess {
            completionHandler(
                .success(
                    [
                        Historic(
                            symbolID: "BINANCE",
                            timeExchange: .empty,
                            timeCoinapi: .empty,
                            uuid: .empty,
                            price: .zero,
                            size: .zero,
                            takerSide: .buy
                        )
                    ]
                )
            )
        } else {
            completionHandler(
                .failure(.invalidRequest)
            )
        }
    }
}
