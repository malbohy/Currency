//
//  UIViewExtenstions.swift
//  AccessabilityIdExtenstions
//
//  Created by mohamed albohy on 07/07/2021.
//

import UIKit
public extension UIViewController {
    
    // Add UIViewController as a subview of another UIView
    func add(viewController: UIViewController, toView parentView: UIView, rect: CGRect) {
        viewController.view.frame = rect
        parentView.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
}
