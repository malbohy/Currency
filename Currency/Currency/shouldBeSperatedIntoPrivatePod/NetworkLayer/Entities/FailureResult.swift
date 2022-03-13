//
//  FailureResult.swift
//  Currency
//
//  Created by elbohy on 10/03/2022.
//

import Foundation

public struct FailureResult {
    public var statusCode: Int?
    public var urlErrorCode: URLError.Code?
    public var response: Any?
    public var error: Error?   // any other or unknown
    public var requestIndex: Int?
    
    init(error: Error) {
        self.error = error
        response = nil
        statusCode = nil
        urlErrorCode = nil
    }
    
    init(urlErrorCode: URLError.Code) {
        self.urlErrorCode = urlErrorCode
        response = nil
        statusCode = nil
        error = nil
    }
    
    init(response: Any?, statusCode: Int?) {
        self.response = response
        self.statusCode = statusCode
        urlErrorCode = nil
        error = nil
    }
}
