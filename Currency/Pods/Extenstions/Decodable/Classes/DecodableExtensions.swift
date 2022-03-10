//
//  UIViewExtenstions.swift
//  AccessabilityIdExtenstions
//
//  Created by mohamed albohy on 07/07/2021.
//
import Foundation

public extension Decodable {
    
    static func decode(jsonString: String) -> Self? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Self.self, from: Data(jsonString.utf8))
        } catch {
            return nil
        }
    }
    
    static func decode(jsonDictionary: [String: Any]) -> Self? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            return try decoder.decode(Self.self, from: jsonData)
        } catch {
            return nil
        }
    }
}
