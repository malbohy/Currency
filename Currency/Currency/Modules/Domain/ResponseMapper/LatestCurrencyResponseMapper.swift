//
//  LatestCurrencyResponseMapper.swift
//  Currency
//
//  Created by elbohy on 13/03/2022.
//

import Foundation

extension LatestCurrencyResponse: ResponseMapper {
    func mapped() -> Any {
        return LatestCurrency(success: self.success ?? false,
                              timestamp: self.timestamp ?? 0,
                              base: self.base ?? "",
                              date: self.date ?? "",
                              rates: self.rates ?? [:])
    }
}
