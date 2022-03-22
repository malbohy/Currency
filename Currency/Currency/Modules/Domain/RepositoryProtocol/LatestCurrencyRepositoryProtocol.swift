//
//  LatestCurrencyRepositoryProtocol.swift
//  Currency
//
//  Created by elbohy on 13/03/2022.
//

import Foundation

typealias LatestCompletionHandler<Response: Codable> = (_ response: Response) -> Void
typealias LatestErrorHandler<Response: Codable> = (_ error: AppError,
                                       _ errorBody: Response?) -> Void

protocol LatestCurrencyRepositoryProtocol {
    func requestData(
        parameters: [String: Any],
        headers: [String: String],
        completionHandeler: @escaping LatestCompletionHandler<LatestCurrencyResponse>,
        errorHandeler: @escaping LatestErrorHandler<LatestCurrencyResponse>)
}
