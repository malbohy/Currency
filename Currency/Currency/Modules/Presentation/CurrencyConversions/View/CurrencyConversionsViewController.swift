//
//  CurrencyConversionsViewController.swift
//  Currency
//
//  Created by elbohy on 13/03/2022.
//

import UIKit
import Extenstions
import RxSwift
import RxCocoa

class CurrencyConversionsViewController: UIViewController, Alertable, ViewLockable {

    // MARK: IBOutlets
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var swapButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var detailsButton: UIButton!
    
    var viewModel: CurrencyConversionsViewModel!
    
    // MARK: Instance Variables
    private var availableCurrencies = ["Cancel"]
    private var disposeBag = DisposeBag()
    private var convertedCurrency = ConvertableCurrency()
    
    init() {
        super.init(nibName: "CurrencyConversionsView", bundle: nil)
        viewModel = CurrencyConversionsViewModel(repository: LatestCurrencyRepository())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllCurrencies()
        
        self.viewModel.convertedCurrencyFromObservable.subscribe(onNext: { [weak self] convertedCurrency in
            guard let self = self else { return }
            self.fromTextField.text = convertedCurrency.fromAmount
            self.toTextField.text = convertedCurrency.toAmount
        }).disposed(by: disposeBag)
        
        self.viewModel.convertedCurrencyToObservable.subscribe(onNext: { [weak self] convertedCurrency in
            guard let self = self else { return }
            self.fromTextField.text = convertedCurrency.fromAmount
            self.toTextField.text = convertedCurrency.toAmount
        }).disposed(by: disposeBag)
    }
    
    private func getAllCurrencies() {
        self.lock(view: self.view, lockBackgroundColor: .clear, indicatorColor: .red)
        viewModel
            .allCurrunciesObservable
            .subscribe(onNext: { [weak self] allCurruncies in
                guard let self = self else { return }
            self.availableCurrencies.insert(contentsOf: allCurruncies, at: 0)
            self.unlock(view: self.view)
        }).disposed(by: disposeBag)
        viewModel.requestAllCurncies()
    }
    
    private func submitValuesToViewModelIfReady(isFrom: Bool) {
        if self.convertedCurrency.isAllValuesReady() {
            if isFrom {
                self.viewModel.convertableCurrencyFromSubject.accept(self.convertedCurrency)
            } else {
                self.viewModel.convertableCurrencyToSubject.accept(self.convertedCurrency)
            }
        }
    }
    
    @IBAction func fromButtonAction(_ sender: Any) {
        self.showAlert(with: LocalizedStrings.fromCurrency,
                       message: LocalizedStrings.select,
                       preferredStyle: .actionSheet,
                       buttonsTitles: availableCurrencies) { [weak self] indexClicked in
            guard let self = self else { return }
            guard indexClicked != (self.availableCurrencies.count - 1) else { return }
            self.fromButton.setTitle(self.availableCurrencies[indexClicked], for: .normal)
            self.convertedCurrency.fromCurrency = self.availableCurrencies[indexClicked]
            self.submitValuesToViewModelIfReady(isFrom: true)
        }
        
    }
    
    @IBAction func swapButtonAction(_ sender: UIButton) {
        let fromValue = fromTextField.text
        let toValue = toTextField.text
        self.fromTextField.text = toValue
        self.toTextField.text = fromValue
        if let fromButtonTitle = self.fromButton.titleLabel?.text,
           fromButtonTitle.lowercased() != LocalizedStrings.from,
           let toButtonTitle = self.toButton.titleLabel?.text,
           toButtonTitle.lowercased() != LocalizedStrings.to {
            self.fromButton.setTitle(toButtonTitle, for: .normal)
            self.toButton.setTitle(fromButtonTitle, for: .normal)
        }
        self.convertedCurrency.swapValues()
    }
    
    @IBAction func toButtonAction(_ sender: Any) {
        self.showAlert(with: LocalizedStrings.toCurrency,
                       message: LocalizedStrings.select,
                       preferredStyle: .actionSheet,
                       buttonsTitles: availableCurrencies) { [weak self] indexClicked in
            guard let self = self else { return }
            guard indexClicked != (self.availableCurrencies.count - 1) else { return }
            self.toButton.setTitle(self.availableCurrencies[indexClicked], for: .normal)
            self.convertedCurrency.toCurrency = self.availableCurrencies[indexClicked]
            self.submitValuesToViewModelIfReady(isFrom: false)
        }
    }
    
    @IBAction func toTextFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        if text == LocalizedStrings.zero {
            self.toTextField.text = LocalizedStrings.one
        } else if text.isEmpty {
            self.fromTextField.text?.removeAll()
            self.convertedCurrency.fromAmount.removeAll()
        }
        self.convertedCurrency.toAmount = self.toTextField.text ?? ""
        self.submitValuesToViewModelIfReady(isFrom: false)
        
    }
    
    @IBAction func fromTextFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        if text == LocalizedStrings.zero {
            self.fromTextField.text = LocalizedStrings.one
        } else if text.isEmpty {
            self.toTextField.text?.removeAll()
            self.convertedCurrency.toAmount.removeAll()
        }
        if self.fromButton.titleLabel?.text != LocalizedStrings.from,
           self.toButton.titleLabel?.text != LocalizedStrings.to {
            self.convertedCurrency.fromAmount = self.fromTextField.text ?? ""
            self.submitValuesToViewModelIfReady(isFrom: true)
        }
        
    }
}
