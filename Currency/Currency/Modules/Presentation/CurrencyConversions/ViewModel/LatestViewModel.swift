//
//  LatestViewModel.swift
//  Currency
//
//  Created by elbohy on 13/03/2022.
//

import Foundation

struct LatestViewModel: LatestViewModelProtocol {
    
    // MARK: base type
    typealias ScreenModel = LatestCurrency
    typealias ResponseModel = LatestCurrencyResponse
    typealias RepositoryType = LatestCurrencyRepositoryProtocol
    
    // MARK: Internal
    // MARK: Repositories
    private var repository: LatestCurrencyRepositoryProtocol
    
    // MARK: Subjects
    private var screenDataSubject: PublishRelay<LatestCurrency> = PublishRelay()
    private var isLoadingSubject: PublishRelay<Bool> = PublishRelay()
    private var isConnectedSubject: PublishRelay<Bool> = PublishRelay()
    private var errorsSubject: PublishRelay<(AppError, LatestCurrencyResponse?)> = PublishRelay()
    
    // MARK: Observables
    lazy var screenDataObservable: Observable<LatestCurrency> = { screenDataSubject.asObservable() }()
    lazy var isLoadingObservable: Observable<Bool> = { isLoadingSubject.asObservable() }()
    lazy var isConnectedObservable: Observable<Bool> = { isConnectedSubject.asObservable() }()
    lazy var errorsObservable: Observable<(AppError, LatestCurrencyResponse?)> = { errorsSubject.asObservable() }()
    
    init(repository: LatestCurrencyRepositoryProtocol) {
        self.repository = repository
    }
    
    func requestScreenData() {
        
        var parameters: [String: String] = [:]
        var headers: [String: String] = [:]
        
        if ReachabilityManager.shared.isReachable {
            isLoadingSubject.accept(true)
            repository.requestData(parameters: [:],
                                   headers: [:]) { response in
                
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
    
    
    
}




import RxSwift
import RxRelay

//protocol ViewModelBaseProtocol {
//
//    // MARK: each data Provider base type
//    associatedtype ScreenModel
//    associatedtype ResponseModel: Codable
//    associatedtype RepositoryType
//    // MARK: Internal
//    // MARK: Repositories
//    var repository: RepositoryType { get }
//    // MARK: Subjects
//    var screenDataSubject: PublishRelay<ScreenModel> { get }
//    var isLoadingSubject: PublishRelay<Bool> { get }
//    var isConnectedSubject: PublishRelay<Bool> { get }
//    var errorsSubject: PublishRelay<(AppError, ResponseModel?)> { get }
//
//}

//extension ViewModelBaseProtocol {
//
////    func requestScreenData(service: Endpoints,
////                           cached: Bool = false,
////                           bodyParameters: [String: String] = [:],
////                           headers: [String: String] = [:]) {
////
////        if ReachabilityManager.shared.isReachable {
////            isLoadingSubject.accept(true)
////            screenDataApiRequest(cached: cached,
////                                 bodyParameters: bodyParameters,
////                                 service: service,
////                                 headers: headers)
////        } else if cached {
////            getCachedData(bodyParameters: bodyParameters,
////                          service: service,
////                          headers: headers)
////        } else {
////            postError(error: AppError.noConnection, errorBody: nil)
////        }
////    }
//
////    private func screenDataApiRequest(bodyParameters: [String: String],
////                                      service: Endpoints,
////                                      headers: [String: String]) {
//////        guard let repository = repository as? BaseRepositoryProtocol else {
//////            self.postError(error: .isNotBaseRepositoryProtocolType, errorBody: nil)
//////            return
//////        }
////        repository.requestData(parameters: bodyParameters,
////                               service: service,
////                               headers: headers,
////                               type: ResponseModel.self) { postsResponse in
////            if cached {
////                guard let cachedRepository = cachedRepository as? BaseCachedRepositoryProtocol else {
////                    self.postError(error: .isNotBaseCachedRepositoryProtocolType, errorBody: nil)
////                    return
////                }
////                cachedRepository.cach(response: postsResponse)
////
////            }
////            self.mappedObjects(response: postsResponse)
////            isLoadingSubject.accept(false)
////        } errorHandeler: { error, errorBody in
////            if cached {
////                getCachedData(bodyParameters: bodyParameters,
////                              service: service,
////                              headers: headers)
////            } else {
////                self.postError(error: error, errorBody: errorBody)
////            }
////            isLoadingSubject.accept(false)
////        }
////    }
//
////    private func getCachedData(bodyParameters: [String: String],
////                               service: Endpoints,
////                               headers: [String: String]) {
////        guard let cachedRepository = cachedRepository as? BaseCachedRepositoryProtocol else {
////            self.postError(error: .isNotBaseCachedRepositoryProtocolType, errorBody: nil)
////            return
////        }
////        cachedRepository.requestData(parameters: bodyParameters,
////                                          service: service,
////                                          headers: headers,
////                                          type: ResponseModel.self) { response in
////            self.mappedObjects(response: response)
////            isLoadingSubject.accept(false)
////        } errorHandeler: { error, errorBody in
////            self.postError(error: error, errorBody: errorBody)
////        }
////    }
//
////    private func mappedObjects(response: Codable) {
////        if let response = response as? [ResponseMapper],
////           let mappedObjects = response.map({$0.mapped()}) as? ScreenModel {
////            self.screenDataSubject.accept(mappedObjects)
////
////            return
////        } else if let response = response as? ResponseMapper,
////                  let mappedObjects = response.mapped() as? ScreenModel {
////             self.screenDataSubject.accept(mappedObjects)
////        } else {
////            self.errorsSubject.accept((.isNotResponseMapperType, nil))
////        }
////    }
//
////    private func postError(error: AppError, errorBody: ResponseModel?) {
////        if error == .noConnection {
////            self.isConnectedSubject.accept(false)
////        } else {
////            print("""
////
////==========================================================================================
////Class Named: \(type(of: self))
////has Error: \(error)
////and Error Body Is: \(String(describing: errorBody?.JSONString()))
////==========================================================================================
////
////""")
////            self.errorsSubject.accept((error, errorBody))
////        }
////        self.isLoadingSubject.accept(false)
////    }
//}



