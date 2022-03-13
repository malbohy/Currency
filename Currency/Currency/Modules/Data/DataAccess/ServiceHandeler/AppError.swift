//
//  AppError.swift
//  Currency
//
//  Created by elbohy on 12/03/2022.
//

import Foundation
enum AppError: Error {
    
    case noConnection
    case unexpectedError
    case decoderError
    case emptyResponse
    case isNotBaseRepositoryProtocolType
    case isNotBaseCachedRepositoryProtocolType
    case isNotResponseMapperType
    case badRequest
    case unAuthorized
    case forbidden
    case notFound
    case methodNotAllowed
    case requestTimeOut
    case conflict
    case payloadTooLong
    case URITooLong
    case tooManyRequests
    case internalServerError
    case notImplemented
    case badGateway
    case serviceUnavailable
    case gatewayTimeOut
    
    var errorMessage: String? {
        switch self {
        case .noConnection:
            return "No Connection founded"
        case .unexpectedError:
            return description
        case .decoderError:
            return description
        case .emptyResponse:
            return "emptyResponse"
        default :
            return ""
        }
    }
    
    var code: Int? {
        switch self {
        case .noConnection:
            return -1000
        case .unexpectedError:
            return -1002
        case .decoderError:
            return -1003
        case .emptyResponse:
            return -1004
        default :
            return 00
        }
    }
    
    var description: String {
        return NSLocalizedString("\(self)", comment: "")
    }
}
