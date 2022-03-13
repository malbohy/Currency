//
//  Endpoints.swift
//  Currency
//
//  Created by elbohy on 12/03/2022.
//

import Foundation
private struct API {
    fileprivate static let postsBaseUrl = "http://data.fixer.io/api/"
}

enum Endpoints {
    
    case latest
    
    private var path: String {
        switch self {
        case .latest:
            return "latest"
        }
    }
    
    var url: String {
        switch self {
        case .latest:
            return API.postsBaseUrl + path
        }
    }
    
    var httpMethod: HTTPMethodType {
        switch self {
        case .latest:
            return .get
        }
    }
    
    private func buildURLComponents(baseURL: String, urlParameters: [String: String]) -> String {
        var comps = URLComponents(string: baseURL)!
        for urlParameter in urlParameters {
            let searchText = URLQueryItem(name: urlParameter.key, value: urlParameter.value)
            if comps.queryItems == nil {
                comps.queryItems = [searchText]
            } else {
                comps.queryItems?.append(searchText)
            }
        }
        guard let url = comps.url?.description  else { fatalError("Failed To Build URL Components") }
        return url
    }
}

// MARK: - Description
extension Endpoints {
    var description: String {
        switch self {
        case .latest:
            return "Latest"
        }
    }
}
