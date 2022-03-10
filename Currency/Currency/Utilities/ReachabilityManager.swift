//
//  ReachabilityManager.swift
//  Currency
//
//  Created by elbohy on 10/03/2022.
//

import Foundation
import Reachability

extension Notification.Name {
    
    static let Reachable = Notification.Name("Reachable")
    static let NotReachable = Notification.Name("NotReachable")
}

class ReachabilityManager: NSObject {

    // MARK: - Life cycle
    public static var shared = ReachabilityManager()
    
    private var reachability: Reachability

    var isReachable: Bool {
        return reachability.isReachable()
    }
    
    var isReachableViaWiFi: Bool {
        return reachability.isReachableViaWiFi()
    }
    
    private override init() {
        self.reachability = Reachability.forInternetConnection()
        super.init()
    }
    
    /// Start oberving changed in internet connection reachability
    func observe() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged, object: nil)
        reachability.startNotifier()
    }
    
    @objc private func reachabilityChanged(notification: Notification) {
        if reachability.isReachable() {
            NotificationCenter.default.post(name: .Reachable, object: nil)
        } else {
            NotificationCenter.default.post(name: .NotReachable, object: nil)
        }
    }
}
