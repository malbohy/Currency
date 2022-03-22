//
//  Alertable.swift
//  Currency
//
//  Created by elbohy on 13/03/2022.
//

import Foundation
import UIKit

protocol Alertable {
    
}

extension Alertable where Self: UIViewController {
    
    func showAlert(in viewController: UIViewController, title: String? = nil, message: String?,
                   actionTitle: String = "OK", completion:(() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { _ in
            alertController.dismiss(animated: true, completion: nil)
            completion?()
        }))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(with title: String? = nil, message: String?, preferredStyle: UIAlertController.Style = .alert,
                   buttonsTitles: [String] = ["OK"], completion: @escaping (Int) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for (index, title) in buttonsTitles.enumerated() {
            var style: UIAlertAction.Style = .default
            if title.localized == "Cancel".localized {
                style = .cancel
            } else if title.localized == "Continue".localized {
                style = .destructive
            }
            let action = UIAlertAction(title: title, style: style) { (_) in
                completion(index)
            }
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func showDisconnectedAlert() {
        self.showAlert(in: self, title: "LocalizedStrings.disconnected",
                       message: "LocalizedStrings.checkYourInternetConnection",
                       actionTitle: "LocalizedStrings.ok",
                       completion: nil)
    }
    
    func showAlert(with title: String? = nil,
                   message: String?,
                   preferredStyle: UIAlertController.Style = .alert,
                   buttonsTitles: [(String, UIAlertAction.Style)] = [("OK", .default)],
                   completion: @escaping (Int) -> Void) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
            for (index, action) in buttonsTitles.enumerated() {
                let alertAction = UIAlertAction(title: action.0, style: action.1) { (_) in
                    completion(index)
                }
                alert.addAction(alertAction)
            }
            self.present(alert, animated: true, completion: nil)
    }
}
