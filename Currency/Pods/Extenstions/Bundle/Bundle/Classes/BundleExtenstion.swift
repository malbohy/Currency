//
//  BundleExtenstion.swift
//  Bundle
//
//  Created by mohamed albohy on 13/07/2021.
//

import Foundation
public extension Bundle {
    
    var appName: String {
        self.infoDictionary?["CFBundleDisplayName"] as? String ?? "no name Found"
    }
    
    var appVersion: String {
        self.infoDictionary?["CFBundleShortVersionString"] as? String ?? "no Version Found"
    }
}
