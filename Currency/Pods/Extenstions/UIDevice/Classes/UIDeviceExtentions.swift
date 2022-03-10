//
//  UIViewExtenstions.swift
//  AccessabilityIdExtenstions
//
//  Created by mohamed albohy on 07/07/2021.
//
import UIKit

public extension UIDevice {
    
    func isPhone() -> Bool {
        return self.userInterfaceIdiom == .phone
    }
    
    func isPad() -> Bool {
        return self.userInterfaceIdiom == .pad
    }
    
    func isPad12() -> Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
            && (UIScreen.main.bounds.size.height == 1366 || UIScreen.main.bounds.size.width == 1366) {
            return true
        }
        return false
    }
}
