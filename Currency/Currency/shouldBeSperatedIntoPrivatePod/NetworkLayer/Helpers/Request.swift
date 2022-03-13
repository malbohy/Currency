//
//  NetworkHelpers.swift
//  Currency
//
//  Created by elbohy on 10/03/2022.
//

import Foundation

class Request {
    class func build(httpMethod: HTTPMethodType,
                     url: String,
                     parameters: [String: Any]? = [:],
                     headersDic: [String: String]?) -> URLRequest {
        var urlComponents = URLComponents(string: url)!
        if httpMethod == .get {
            urlComponents = Request.addGetParameters(urlComponents: urlComponents,
                                                     parameters: parameters)
        }
        
        var requestURL = urlComponents.url!
        let requestPath = requestURL.absoluteString.replacingOccurrences(of: "+", with: "%2B")
        requestURL = URL(string: requestPath) ?? requestURL
        
        var request  = URLRequest(url: requestURL)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headersDic
        
        if httpMethod != .get {
            request = Request.addNotGetParameters(request: request,
                                                  parameters: parameters)
        }
        return request
    }
    
    private class func addGetParameters(urlComponents: URLComponents,
                                        parameters: [String: Any]?) -> URLComponents {
        var urlComponents = urlComponents
        var params: [String: Any] = [:]
        
        if let parameters = parameters {
            params = parameters
        }
        if urlComponents.queryItems == nil {
            urlComponents.queryItems = []
        }
        for(key, value) in params {
            urlComponents.queryItems?.append(URLQueryItem(name: key, value: value as? String))
        }
        return urlComponents
    }
    
    private class func addNotGetParameters(request: URLRequest,
                                           parameters: [String: Any]?) -> URLRequest {
        var request = request
        if let parameters = parameters {
            request.httpBody = getPostString(params: parameters).data(using: .utf8) ?? Data()
        }
        return request
    }
    
    private class func getPostString(params: [String: Any]) -> String {
        var data = [String]()
        for(key, value) in params {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
}
