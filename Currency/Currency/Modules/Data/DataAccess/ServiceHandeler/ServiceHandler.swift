//
//  ServiceHandler.swift
//  Currency
//
//  Created by elbohy on 12/03/2022.
//

import Foundation
typealias ErrorHandler<T: Codable> = (_ error: AppError, _ response: T?) -> Void
typealias SuccessHandler<T: Codable> = (_ reponse: T?) -> Void

protocol ServiceHandler {
    
    func request <T: Codable> (service: Endpoints,
                               model: T.Type,
                               parameters: [String: Any],
                               headers: [String: String]?,
                               successHandler: @escaping SuccessHandler<T>,
                               errorHandler: @escaping ErrorHandler<T>)
}

extension ServiceHandler {
    
    func request <T: Codable> (service: Endpoints,
                               model: T.Type,
                               parameters: [String: Any],
                               headers: [String: String]? = nil,
                               successHandler: @escaping SuccessHandler<T>,
                               errorHandler: @escaping ErrorHandler<T>) {
        
        guard ReachabilityManager.shared.isReachable else {
            errorHandler(AppError.noConnection, nil)
            return
        }
        var allHeadersFields: [String: String] = headers ?? [:]
        allHeadersFields["Content-Type"] = "application/json"
        
        var parameters: [String: Any] = parameters
        parameters.merge(APIConstant.Parameters.accessTokesn, uniquingKeysWith: { _, _ in })
        
        ApiManager.execute(url: service.url,
                           httpMethod: service.httpMethod,
                           headersDic: allHeadersFields,
                           parameters: parameters,
                           successHandler: { (successResult) in
            self.handleSuccessResponse(successResult: successResult,
                                       service: service,
                                       model: model,
                                       parameters: parameters,
                                       headers: headers ?? [:],
                                       successHandler: successHandler,
                                       errorHandler: errorHandler)
            
        }, failureHandler: { (failureResult) in
            self.handleFailureResponse(failureResult: failureResult,
                                       service: service,
                                       model: model,
                                       parameters: parameters,
                                       headers: headers ?? [:],
                                       successHandler: successHandler,
                                       errorHandler: errorHandler)
        })
    }
}

// MARK: - Handle Response
extension ServiceHandler {
    
    // MARK: Handle success response
    private func handleSuccessResponse <T: Codable> (successResult: SuccessResult,
                                                     service: Endpoints,
                                                     model: T.Type?,
                                                     parameters: [String: Any],
                                                     headers: [String: String],
                                                     successHandler: @escaping SuccessHandler<T>,
                                                     errorHandler: @escaping ErrorHandler<T>) {
        guard let data = successResult.response as? Data else {
            print("""
                  file: \(#file)
                  function :\(#function)
                  Line : \(#line)
                  """)
            errorHandler(AppError.unexpectedError, nil)
            return
        }
        
        if let model = model {
            do {
                // Decode Data
                let decoder = JSONDecoder()
                let model = try decoder.decode(model, from: data)
                successHandler(model)
            } catch let error {
                debugPrint("data \(String(data: data, encoding: .utf8)!)")
                debugPrint("error \(error as! DecodingError)")
                errorHandler(AppError.decoderError, nil)
            }
        } else {
            successHandler(nil)
        }
    }
    
    // MARK: Handle failure response
    private func handleFailureResponse <T: Codable> (failureResult: FailureResult,
                                                     service: Endpoints,
                                                     model: T.Type,
                                                     parameters: [String: Any],
                                                     headers: [String: String],
                                                     successHandler: @escaping (T?) -> Void,
                                                     errorHandler: @escaping ErrorHandler<T>) {
        let response = decodeResponse(data: failureResult.response as? Data, model: T.self)
        if failureResult.urlErrorCode == URLError.notConnectedToInternet ||
            failureResult.urlErrorCode == URLError.networkConnectionLost {
            errorHandler(AppError.noConnection, response)
        } else {
            guard let httpErrorStatusCode = failureResult.statusCode else {
                print("""
                      file: \(#file)
                      function :\(#function)
                      Line : \(#line)
                      """)
                errorHandler(AppError.unexpectedError, response)
                return
            }
            switch httpErrorStatusCode {
            case HTTPErrorStatusCode.badRequest.rawValue:
                errorHandler(AppError.badRequest, response)
            case HTTPErrorStatusCode.unAuthorized.rawValue:
                errorHandler(AppError.unAuthorized, response)
            case HTTPErrorStatusCode.forbidden.rawValue:
                errorHandler(AppError.forbidden, response)
            case HTTPErrorStatusCode.notFound.rawValue:
                errorHandler(AppError.notFound, response)
            case HTTPErrorStatusCode.methodNotAllowed.rawValue:
                errorHandler(AppError.methodNotAllowed, response)
            case HTTPErrorStatusCode.requestTimeOut.rawValue:
                errorHandler(AppError.requestTimeOut, response)
            case HTTPErrorStatusCode.conflict.rawValue:
                errorHandler(AppError.conflict, response)
            case HTTPErrorStatusCode.payloadTooLong.rawValue:
                errorHandler(AppError.payloadTooLong, response)
            case HTTPErrorStatusCode.URITooLong.rawValue:
                errorHandler(AppError.URITooLong, response)
            case HTTPErrorStatusCode.tooManyRequests.rawValue:
                errorHandler(AppError.tooManyRequests, response)
            case HTTPErrorStatusCode.internalServerError.rawValue:
                errorHandler(AppError.internalServerError, response)
            case HTTPErrorStatusCode.notImplemented.rawValue:
                errorHandler(AppError.notImplemented, response)
            case HTTPErrorStatusCode.badGateway.rawValue:
                errorHandler(AppError.badGateway, response)
            case HTTPErrorStatusCode.serviceUnavailable.rawValue:
                errorHandler(AppError.serviceUnavailable, response)
            case HTTPErrorStatusCode.gatewayTimeOut.rawValue:
                errorHandler(AppError.gatewayTimeOut, response)
            default:
                print("""
                      file: \(#file)
                      function :\(#function)
                      Line : \(#line)
                      \(httpErrorStatusCode)
                      """)
                errorHandler(AppError.unexpectedError, response)
            }
            
        }
    }
    
    private func decodeResponse<T: Codable>(data: Data?, model: T.Type) -> T? {
        guard let data = data else { return nil}
        do {
            // Decode Data
            let decoder = JSONDecoder()
            let model = try decoder.decode(model, from: data)
            return model
        } catch let error {
            debugPrint("data \(String(data: data, encoding: .utf8)!)")
            debugPrint("error \(error as! DecodingError)")
            return nil
        }
    }
}
