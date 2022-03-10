//
//  UIViewExtenstions.swift
//  AccessabilityIdExtenstions
//
//  Created by mohamed albohy on 07/07/2021.
//

import Foundation
import UIKit

public extension UIScrollView {
    
    func scrollTo(view: UIView, keyboardSize: CGRect) {
        var visiableRect = self.bounds
        visiableRect.size.height -= keyboardSize.height
        let buttonGlobalRect = view.convert(view.bounds, to: self)
        if !visiableRect.contains(buttonGlobalRect) {
            let extraBottomMargin: CGFloat = 8
            let contentInsets = UIEdgeInsets(top: 0.0,
                                             left: 0.0,
                                             bottom: keyboardSize.height + extraBottomMargin,
                                             right: 0.0)
            self.contentInset = contentInsets
            self.scrollIndicatorInsets = contentInsets
            DispatchQueue.main.async {
                self.scrollRectToVisible(buttonGlobalRect, animated: true)
            }
        }
    }
    
    func resetContentInset() {
        let contentInsets = UIEdgeInsets.zero
        self.contentInset = contentInsets
        self.scrollIndicatorInsets = contentInsets
    }
    
    func scrollTo(view: UIView, bottomInset: CGFloat = .zero) {
        var visiableRect = self.bounds
        visiableRect.size.height -= bottomInset
        let buttonGlobalRect = view.convert(view.bounds, to: self)
        if !visiableRect.contains(buttonGlobalRect) {
            let contentInsets = UIEdgeInsets(top: 0.0,
                                             left: 0.0,
                                             bottom: bottomInset,
                                             right: 0.0)
            self.contentInset = contentInsets
            self.scrollIndicatorInsets = contentInsets
            DispatchQueue.main.async {  [weak self] in
                guard let self = self else { return }
                self.scrollRectToVisible(buttonGlobalRect, animated: true)
            }
        }
    }
}
