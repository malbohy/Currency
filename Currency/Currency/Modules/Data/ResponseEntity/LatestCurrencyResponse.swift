//
//  LatestCurrencyResponse.swift
//  Currency
//
//  Created by elbohy on 13/03/2022.
//

import Foundation
import Extenstions

struct LatestCurrencyResponse: Codable {
    let success: Bool?
    let timestamp: Int?
    let base, date: String?
    let rates: [String: Double]?
    
    enum CodingKeys: String, CodingKey {
        case success
        case timestamp
        case base
        case date
        case rates
    }
}
