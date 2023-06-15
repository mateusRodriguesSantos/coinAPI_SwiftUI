//
//  Exchange.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 10/06/23.
//

import Foundation

struct Exchange: Codable, Identifiable {
    var id: Int = UUID().hashValue
    
    let exchangeID: String?
    let name: String?
    let volume1DayUsd: Double?
    let volume1hrs: Double?
    let volume1month: Double
    let quoteStart: String?
    let website: String?
    let dataEnd: String?
    let dataStart: String?


    enum CodingKeys: String, CodingKey {
        case exchangeID = "exchange_id"
        case name
        case volume1DayUsd = "volume_1day_usd"
        case volume1hrs = "volume_1hrs"
        case volume1month = "volume_1mth_usd"
        case quoteStart = "data_quote_start"
        case website
        case dataEnd = "data_end"
        case dataStart = "data_start"
    }
}
