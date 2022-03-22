//
//  ViewController.swift
//  Currency
//
//  Created by elbohy on 10/03/2022.
//

import UIKit

class ViewController: UIViewController, ServiceHandler {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        /*
         API Key Is : ffc9529e20f9b1230a77eb8394833ac4

         
         
         base URL : http://data.fixer.io/api/latest?access_key=ffc9529e20f9b1230a77eb8394833ac4

         
         
         http://data.fixer.io/api/latest

             ? access_key = YOUR_ACCESS_KEY
             & base = GBP
             & symbols = USD,AUD,CAD,PLN,MXN
         
         
         
         http://data.fixer.io/api/latest?access_key=ffc9529e20f9b1230a77eb8394833ac4&base=EGP&symbols=USD
         
         
         
         
//         */
//        request(service: .latest,
//                model: Photos.self,
//                parameters: ["access_keyyyyy":"usd", "mohamed": "ahmed"], headers: nil) { reponse in
//            print(reponse)
//        } errorHandler: { error, response in
//            print(error)
//        }

        
        
    }
}
