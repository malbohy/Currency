//
//  AccessabilityIdExtenstion.swift
//  ExtenstionsAccessabilityId
//
//  Created by mohamed albohy on 06/07/2021.
//

import UIKit

public extension UIAlertController {
    
    /// sets Accessability Id for each action in the alert , using the baseAccessabilityId parameter and append the index of the action in the end of the ID
    /// - Parameter baseAccessabilityId: each action AccessabilityID to be written before the action index like ( baseAccessabilityId-actionIndex )
    func setActions(baseAccessabilityId: String) {
        for (index, action) in self.actions.enumerated() {
            action.accessibilityIdentifier = "\(baseAccessabilityId)-\(index)"
        }
    }
    
    /// sets Accessability id for alert title label
    /// - Parameter accessabilityId: string will be added as accessability id for title label
    func setTitle(accessabilityId: String) {
        let alertTitle = view.subviewsRecursive().first(where: { $0 is UILabel && ($0 as? UILabel)?.text == title })
        alertTitle?.accessibilityIdentifier = accessabilityId
    }
    
    /// sets Accessability id for alert message label
    /// - Parameter accessabilityId: string will be added as accessability id for mesage label
    func setMessage(accessabilityId: String) {
        let alerMessage = view.subviewsRecursive().first(where: { $0 is UILabel && ($0 as? UILabel)?.text == message })
        alerMessage?.accessibilityIdentifier = accessabilityId
    }
}
