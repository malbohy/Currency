//
//  EncodableExtenstion.swift
//  Encodable
//
//  Created by mohamed albohy on 13/07/2021.
//

import Foundation

public extension Encodable {
    
    func JSONString() -> String? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func JSONDictionary() -> [String: Any]? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            let JSON = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            return JSON
        } catch let error {
            print(error)
            return nil
        }
    }
}
