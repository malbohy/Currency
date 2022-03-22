//
//  ResponseMapperProtocol.swift
//  Currency
//
//  Created by elbohy on 13/03/2022.
//

import Foundation

protocol ResponseMapper where Self: Codable {
    func mapped() -> Any
}
