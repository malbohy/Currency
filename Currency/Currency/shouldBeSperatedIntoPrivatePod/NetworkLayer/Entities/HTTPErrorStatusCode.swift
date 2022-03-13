//
//  HTTPErrorStatusCode.swift
//  Currency
//
//  Created by elbohy on 12/03/2022.
//

import Foundation

enum HTTPErrorStatusCode: Int {
    
    case badRequest = 400
    case unAuthorized = 401
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case requestTimeOut = 408
    case conflict = 409
    case payloadTooLong = 413
    case URITooLong = 414
    case tooManyRequests = 429
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeOut = 504
}
