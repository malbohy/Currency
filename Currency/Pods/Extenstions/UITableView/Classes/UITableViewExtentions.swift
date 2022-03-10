//
//  UIViewExtenstions.swift
//  AccessabilityIdExtenstions
//
//  Created by mohamed albohy on 07/07/2021.
//

import UIKit

public extension UITableView {
    
    func scroll(to: Position, animated: Bool) {
        let sections = numberOfSections
        let rows = numberOfRows(inSection: numberOfSections - 1)
        if rows < 1 { return }
        switch to {
        case .top:
            let indexPath = IndexPath(row: 0, section: 0)
            scrollToRow(at: indexPath, at: .top, animated: animated)
        case .bottom:
            let indexPath = IndexPath(row: rows - 1, section: sections - 1)
            scrollToRow(at: indexPath, at: .bottom, animated: animated)
        }
    }
    
    enum Position {
        case top
        case bottom
    }
}
