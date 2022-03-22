//
//  LatestViewModelProtocol.swift
//  Currency
//
//  Created by elbohy on 13/03/2022.
//

import Foundation

protocol LatestViewModelProtocol {
    associatedtype ScreenModel = LatestCurrency
    associatedtype ResponseModel = LatestCurrencyResponse
    associatedtype RepositoryType = LatestCurrencyRepositoryProtocol
    init(repository: RepositoryType)
    func requestScreenData()
    
}
