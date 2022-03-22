//
//  ViewLockable.swift
//  Currency
//
//  Created by elbohy on 13/03/2022.
//

import Foundation
import UIKit

let lockViewTag = 2000

protocol ViewLockable {
    
    func lock(view: UIView, showIndicator: Bool, indicatorColor: UIColor, lockBackgroundColor: UIColor, transform: CGFloat)
}

extension ViewLockable {
    
    func lock(view: UIView, showIndicator: Bool, indicatorColor: UIColor, lockBackgroundColor: UIColor,
              transform: CGFloat = 1.0) {
        lock(view: view,
             rect: nil,
             lockBackgroundColor: lockBackgroundColor,
             showIndicator: showIndicator,
             indicatorColor: indicatorColor,
             transform: transform)
    }
    
    func lock(view: UIView,
              rect: CGRect? = nil,
              lockBackgroundColor: UIColor = UIColor(white: 0.0, alpha: 0.5),
              showIndicator: Bool = true,
              indicatorColor: UIColor = UIColor.white,
              transform: CGFloat = 1.0) {
        DispatchQueue.main.async {
            let lockView = UIView()
            lockView.translatesAutoresizingMaskIntoConstraints = false
            lockView.frame = rect ?? view.bounds
            lockView.backgroundColor = lockBackgroundColor
            lockView.tag = lockViewTag
            lockView.alpha = 1.0
            view.addSubview(lockView)
            lockView.pinToSuperViewEdges()
            
            if showIndicator {
                let activity = UIActivityIndicatorView(style: .large)
                activity.transform = CGAffineTransform(scaleX: transform, y: transform)
                activity.translatesAutoresizingMaskIntoConstraints = false
                activity.color = indicatorColor
                activity.center = CGPoint(x: lockView.frame.width / 2,
                                          y: lockView.frame.height / 2)
                activity.hidesWhenStopped = true
                activity.startAnimating()
                lockView.addSubview(activity)
                activity.centerViewToSuperView()
            }
        }
    }
    
    func unlock(view: UIView) {
        if let lockView = view.viewWithTag(lockViewTag) {
            lockView.removeFromSuperview()
        }
    }
}
