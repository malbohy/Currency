//
//  ReplaceMe.swift
//  String
//
//  Created by mohamed albohy on 13/07/2021.
//

import Foundation
// MARK: - Localization
public extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func getDate(withDateFormat dateFormat: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)!
    }
}

public extension String {
    
    func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [Range<Index>] {
        var ranges: [Range<Index>] = []
        while let range = range(of: substring, options: options, range: (ranges.last?.upperBound ?? self.startIndex)..<self.endIndex,
                                locale: locale) {
            ranges.append(range)
        }
        return ranges
    }
}

public extension String {
    func isLessThan(newVersion: String) -> Bool {
        let versionDelimiter = "."
        // split the version by period .
        var versionComponents = self.components(separatedBy: versionDelimiter)
        var otherVersionComponents = newVersion.components(separatedBy: versionDelimiter)
        // find the difference of digit to zero pad
        let zeroDiff = versionComponents.count - otherVersionComponents.count
        // no differences
        if zeroDiff == 0 {
            // Same format, compare normally
            return self.compare(newVersion, options: .numeric) == .orderedAscending
        } else {
            // populate an array of missing zero
            let zeros = Array(repeating: "0", count: abs(zeroDiff))
            if zeroDiff > 0 {
                // add zero pad array to a version with a fewer period and zero
                otherVersionComponents.append(contentsOf: zeros)
            } else {
                versionComponents.append(contentsOf: zeros)
            }
            // build back versions from components and compare them
            return versionComponents.joined(separator: versionDelimiter)
                .compare(otherVersionComponents.joined(separator: versionDelimiter), options: .numeric) == .orderedAscending
        }
    }
}

public extension String {
    
    func rtlEnglishBegningUniCode(languageCode: String) -> String? {
        if languageCode == "ar" {
            return "\u{2067}\(self)"
        } else {
            return self
        }
    }
    
    func rtlEnglishEndingUniCode(languageCode: String) -> String? {
        if languageCode == "ar" {
            return " \(self)\u{2066}"
        } else {
            return self
        }
    }
}

public extension String {
    var inSeconds : Double {
        var total:Double = 0.0
        let secondRatio = [1, 60, 3600]    // ss:mm:HH
        let splitedTime = self.split(separator: ".")
        guard splitedTime.count > 0 else { return 0 }
        if let milliSeconds = splitedTime.last {
            total += (Double(milliSeconds) ?? 0) / 1000
        }
        
        if let time = splitedTime.first {
            for (i, item) in time.components(separatedBy: ":").reversed().enumerated() {
                if i >= secondRatio.count { break }
                total = total + (Double(item) ?? 0) * Double(secondRatio[i])
            }
        }
        return total
    }
    
    var encodeSpacesForURLS: String {
        return self.replacingOccurrences(of: " ", with: "%20")
    }
}
