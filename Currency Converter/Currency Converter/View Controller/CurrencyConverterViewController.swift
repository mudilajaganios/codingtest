//
//  CurrencyConverterViewController.swift
//  Currency Converter
//
//  Created by Jagan Kumar Mudila on 06/01/2021.
//

import UIKit

class CurrencyConverterViewController: UITableViewController {
    
    let currencyCellID = "currencyConverterCell"
    
    var baseCurrency: Currency!
    var otherCurrency: Currency!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Bar
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 63/255.0, green: 149/255.0, blue: 244/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = "Conversion Calculator"
        
        self.tableView.register(CurrencyConversionCell.self, forCellReuseIdentifier: currencyCellID)
        self.tableView.tableFooterView = UIView()
    }
}
    
extension CurrencyConverterViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currecyCell = tableView.dequeueReusableCell(withIdentifier: currencyCellID, for: indexPath) as? CurrencyConversionCell else {
            preconditionFailure("Invalid cell type")
        }
        currecyCell.delegate = self
        if indexPath.row > 0 {
            currecyCell.currency = self.otherCurrency
            currecyCell.currencyInput.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        } else {
            currecyCell.currency = self.baseCurrency
        }
        return currecyCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
}

extension CurrencyConverterViewController: CurrencyConversionCellDelegate {
    func convertCurrencies(baseCode: String, amount: String) {
        DataFixerAPI.instance.convert(baseCurrency: baseCode,
                                      desiredCurrency: self.otherCurrency?.code ?? "",
                                      amount: amount) { [weak self] (conversionData) in
            guard let conversionData = conversionData else {
                return
            }
            
            if self?.baseCurrency.code == baseCode {
                self?.otherCurrency.rate = conversionData.result
            } else if self?.otherCurrency.code == baseCode {
                self?.baseCurrency.rate = conversionData.result
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
