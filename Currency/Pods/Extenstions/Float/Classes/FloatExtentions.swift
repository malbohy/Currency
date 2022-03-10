//
//  UIViewExtenstions.swift
//  AccessabilityIdExtenstions
//
//  Created by mohamed albohy on 07/07/2021.
//

import Foundation

public extension Float {

    func rounded(digits: Int) -> Float {
        let multiplier = pow(10.0, Float(digits))
        return (self * multiplier).rounded() / multiplier
    }
}
