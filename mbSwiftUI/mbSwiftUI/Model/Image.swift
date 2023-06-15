//
//  Image.swift
//  mbSwiftUI
//
//  Created by Mateus Rodrigues on 14/06/23.
//

import Foundation

// MARK: - Welcome
struct ImageExchange: Codable, Identifiable {
    var id: Int = UUID().hashValue
    let assetID: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case assetID = "asset_id"
        case url
    }
}
