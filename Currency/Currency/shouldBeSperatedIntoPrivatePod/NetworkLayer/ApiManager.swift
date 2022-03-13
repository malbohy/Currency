//
//  ApiManager.swift
//  Currency
//
//  Created by elbohy on 10/03/2022.
//

import Foundation
class ApiManager {
    
    class func execute(url: String,
                       httpMethod: HTTPMethodType,
                       headersDic: [String: String]?,
                       parameters: [String: Any]?,
                       successHandler: @escaping ApiSuccessClosure,
                       failureHandler: @escaping ApiFailureClosure) {
        
        let request = Request.build(httpMethod: httpMethod,
                                    url: url,
                                    parameters: parameters,
                                    headersDic: headersDic)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error as? URLError {
                DispatchQueue.main.async {
                    failureHandler(FailureResult(urlErrorCode: error.code))
                }
            } else if let data = data,
                      let responseObj = response as? HTTPURLResponse {
                if responseObj.statusCode == 401 {
                    DispatchQueue.main.async {
                        failureHandler(FailureResult(response: responseObj, statusCode: responseObj.statusCode))
                    }
                } else {
                    if 200 ... 299 ~= responseObj.statusCode {
                        DispatchQueue.main.async {
                            successHandler(SuccessResult(response: data))
                        }
                    } else {
                        DispatchQueue.main.async {
                            failureHandler(FailureResult(response: data, statusCode: responseObj.statusCode))
                        }
                    }
                }
                
            }
        }
        task.resume()
    }
}
