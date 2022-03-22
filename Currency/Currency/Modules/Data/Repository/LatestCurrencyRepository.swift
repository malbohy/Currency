//
//  LatestCurrencyRepository.swift
//  Currency
//
//  Created by elbohy on 13/03/2022.
//

import Foundation

struct LatestCurrencyRepository: LatestCurrencyRepositoryProtocol, ServiceHandler {
    func requestData(parameters: [String: Any],
                     headers: [String: String],
                     completionHandeler: @escaping LatestCompletionHandler<LatestCurrencyResponse>,
                     errorHandeler: @escaping LatestErrorHandler<LatestCurrencyResponse>) {
        
        request(service: .latest,
                model: LatestCurrencyResponse.self,
                parameters: parameters,
                headers: headers,
                successHandler: { response in
            guard let response = response else {
                errorHandeler(.emptyResponse, nil)
                return
            }
            completionHandeler(response)
            
        }, errorHandler: { error, errorResponse in
            errorHandeler(error, errorResponse)
        })
    }
}
