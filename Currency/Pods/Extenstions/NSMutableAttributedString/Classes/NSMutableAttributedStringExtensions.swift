//
//  UIViewExtenstions.swift
//  AccessabilityIdExtenstions
//
//  Created by mohamed albohy on 07/07/2021.
//

import Foundation
import UIKit

public extension NSMutableAttributedString {
    
    func apply(font: UIFont, onOccurrences subString: String) {
        let ranges = self.string.ranges(of: subString)
        ranges.forEach { self.apply(font: font, onRange: NSRange($0, in: self.string)) }
    }
    
    func apply(font: UIFont, subString: String) {
        if let range = self.string.range(of: subString) {
            self.apply(font: font, onRange: NSRange(range, in: self.string))
        }
    }
    
    func apply(font: UIFont, onRange: NSRange) {
        self.addAttributes([NSAttributedString.Key.font: font], range: onRange)
    }
}
