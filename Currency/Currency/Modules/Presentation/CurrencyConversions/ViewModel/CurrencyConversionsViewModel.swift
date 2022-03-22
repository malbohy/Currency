//
//  CurrencyConversionsViewModel.swift
//  Currency
//
//  Created by elbohy on 13/03/2022.
//

import Foundation
import RxSwift
import RxRelay

protocol CurrencyConversionsViewModelProtocol {
    
}

class CurrencyConversionsViewModel: CurrencyConversionsViewModelProtocol {
    
    // MARK: Internal
    // MARK: Repositories
    private var repository: LatestCurrencyRepositoryProtocol
    
    // MARK: Subjects
    private var allCurrunciesSubject: PublishRelay<[String]> = PublishRelay()
    private var isLoadingSubject: PublishRelay<Bool> = PublishRelay()
    private var isConnectedSubject: PublishRelay<Bool> = PublishRelay()
    private var errorsSubject: PublishRelay<(AppError, LatestCurrencyResponse?)> = PublishRelay()
    private var fromConvertedSubject: PublishRelay<String> = PublishRelay()
    private var toConvertedSubject: PublishRelay<String> = PublishRelay()
    
    // MARK: Observables and Subjects
    lazy var allCurrunciesObservable: Observable<[String]> = { allCurrunciesSubject.asObservable() }()
    lazy var isLoadingObservable: Observable<Bool> = { isLoadingSubject.asObservable() }()
    lazy var isConnectedObservable: Observable<Bool> = { isConnectedSubject.asObservable() }()
    lazy var errorsObservable: Observable<(AppError, LatestCurrencyResponse?)> = { errorsSubject.asObservable() }()
    
    var latestCurrency: LatestCurrency?
    
    
    
    
    
    
    var convertableCurrencyFromSubject: PublishRelay<ConvertableCurrency> = PublishRelay<ConvertableCurrency>()
    var convertableCurrencyToSubject: PublishRelay<ConvertableCurrency> = PublishRelay<ConvertableCurrency>()
    private var convertedCurrencyFromSubject: PublishRelay<ConvertableCurrency> = PublishRelay<ConvertableCurrency>()
    private var convertedCurrencyToSubject: PublishRelay<ConvertableCurrency> = PublishRelay<ConvertableCurrency>()
    lazy var convertedCurrencyFromObservable: Observable<ConvertableCurrency> = { convertedCurrencyFromSubject.asObservable() }()
    lazy var convertedCurrencyToObservable: Observable<ConvertableCurrency> = { convertedCurrencyToSubject.asObservable() }()
    
    
    
    init(repository: LatestCurrencyRepositoryProtocol) {
        self.repository = repository
        
        
        
        convertableCurrencyFromSubject.subscribe(onNext: { convertableCurrency in
            print("Got Values to COnvert ")
            self.convert(isFrom: true, convertableCurrency: convertableCurrency)
        })
        
        
        convertableCurrencyToSubject.subscribe(onNext: { convertableCurrency in
            self.convert(isFrom: false, convertableCurrency: convertableCurrency)
        })
        
        
    }
    
    func requestAllCurncies() {
        
        var parameters: [String: String] = [:]
        var headers: [String: String] = [:]
        
        if ReachabilityManager.shared.isReachable {
            isLoadingSubject.accept(true)
            repository.requestData(parameters: [:],
                                   headers: [:]) { response in
                self.latestCurrency = response.mapped() as! LatestCurrency
                guard let currncies = response.rates?.keys else {
                    self.errorsSubject.accept((.emptyResponse, nil))
                    return
                }
                self.allCurrunciesSubject.accept(Array(currncies).sorted())
                
            } errorHandeler: { error, errorBody in
                
            }
            
            //            screenDataApiRequest(cached: cached,
            //                                 bodyParameters: bodyParameters,
            //                                 service: service,
            //                                 headers: headers)
        } else {
            //            postError(error: AppError.noConnection, errorBody: nil)
        }
    }
    
    
    func convert(isFrom: Bool, convertableCurrency: ConvertableCurrency) {
//    from: String, to: String, amount: Double
        var convertableCurrency = convertableCurrency
        let priceForFromCurrencyToEUR = self.latestCurrency?.rates.first(where: {$0.key == convertableCurrency.fromCurrency})?.value
        let priceForToCurrencyToEUR = self.latestCurrency?.rates.first(where: {$0.key == convertableCurrency.toCurrency})?.value
        
        
        if isFrom {
            let amount = Double(convertableCurrency.fromAmount) ?? 1
            let finalPrice = (amount / priceForFromCurrencyToEUR!) * priceForToCurrencyToEUR!
            convertableCurrency.toAmount = String(format: "%.2f", finalPrice)
            
            convertedCurrencyFromSubject.accept(convertableCurrency)
        } else {
            let amount = Double(convertableCurrency.toAmount) ?? 1
            let finalPrice = (amount / priceForToCurrencyToEUR!) * priceForFromCurrencyToEUR!
            convertableCurrency.fromAmount =  String(format: "%.2f", finalPrice)
            convertedCurrencyFromSubject.accept(convertableCurrency)
        }
        
        
        
        
    }
}
