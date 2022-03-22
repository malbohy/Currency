//
//  ConvertableCurrency.swift
//  Currency
//
//  Created by elbohy on 13/03/2022.
//

import Foundation
struct ConvertableCurrency {
    var fromCurrency: String = ""
    var toCurrency: String = ""
    var fromAmount: String = ""
    var toAmount: String = ""
    
    func isAllValuesReady() -> Bool {
        return !fromCurrency.isEmpty && !toCurrency.isEmpty && (!fromAmount.isEmpty || !toAmount.isEmpty)
    }
    
    mutating func swapValues() {
        let oldFromCurrency = fromCurrency
        let oldToCurrency = toCurrency
        let oldFromAmount = fromAmount
        let oldToAmount = toAmount
        fromCurrency = oldToCurrency
        toCurrency = oldFromCurrency
        fromAmount = oldToAmount
        toAmount = oldFromAmount
    }
}
