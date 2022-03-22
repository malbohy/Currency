//
//  LatestCurrency.swift
//  Currency
//
//  Created by elbohy on 13/03/2022.
//

import Foundation

struct LatestCurrency {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}
