//
//  CurrencyConversionsCoordinator.swift
//  Currency
//
//  Created by elbohy on 13/03/2022.
//

import Foundation
import UIKit

struct CurrencyConversionsCoordinator {
    private var currencyConversionsViewController: CurrencyConversionsViewController!
    
    init() {
        self.build()
    }
    
    func start(window: UIWindow) {
        
        window.rootViewController = currencyConversionsViewController
    }
    
    func start(navigationController: UINavigationController) {
        if navigationController.viewControllers.count > 0 {
            navigationController.pushViewController(currencyConversionsViewController, animated: true)
        } else {
            navigationController.setViewControllers([currencyConversionsViewController], animated: true)
        }
        
    }
    
    func start(viewController: UIViewController) {
        viewController.present(currencyConversionsViewController, animated: true, completion: nil)
    }
    
    private mutating func build() {
//        let photoListRepository = PhotoListRepository()
//        let cachedPhotoListRepository = CachedPhotoListRepository()
//        let photoListDataProvider = PhotoListDataProvider(repository: photoListRepository, cachedRepository: cachedPhotoListRepository)
//        let photoListViewModel = PhotoListViewModel(photoListDataProvider: photoListDataProvider)
        self.currencyConversionsViewController = CurrencyConversionsViewController()
    }
}
