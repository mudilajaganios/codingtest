//
//  CurrenciesViewController.swift
//  Currency Converter
//
//  Created by Jagan Kumar Mudila on 06/01/2021.
//

import UIKit

class CurrenciesViewController: UITableViewController {
    
    let currencyCellID = "currencyCell"
    
    var baseCurrency: Currency! {
        didSet {
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    var otherCurrencies: [Currency]! {
        didSet {
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    var currencyPicker: UIPickerView!
    var pickerToolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Bar
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 63/255.0, green: 149/255.0, blue: 244/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = "Currency Converter"
        
        self.tableView.register(CurrencyCellView.self, forCellReuseIdentifier: currencyCellID)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshCurrencies), for: .valueChanged)
        self.tableView.addSubview(self.refreshControl!)
        self.refresh(for: "")
    }
    
    @objc func refreshCurrencies() {
        self.refresh(for: "")
    }
    
    fileprivate func refresh(for baseCurrency: String) {
        DataFixerAPI.instance.getCurrencies(for: baseCurrency) { [weak self] (currencies) in
            guard let currencies = currencies else {
                self?.otherCurrencies = nil
                return
            }
            self?.baseCurrency = Currency(code: currencies.base ?? "", displayName: "", rate: nil)
            self?.otherCurrencies = currencies.rates?.map({ Currency(code: $0.key, displayName: "", rate: $0.value)
            })
        }
    }
    
    func createPickersAndToolbar() {
        // Picker
        currencyPicker = UIPickerView(frame: CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300))
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.autoresizingMask = .flexibleWidth
        currencyPicker.backgroundColor = UIColor.white
//        currencyPicker.setValue(UIColor.sectionHeaderColor, forKey: "textColor")
        self.view.addSubview(currencyPicker)
        
        // Toolbar
        pickerToolBar = UIToolbar(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        pickerToolBar.barStyle = .black
        pickerToolBar.isTranslucent = true
        pickerToolBar.tintColor = .white
        pickerToolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(pickerToolBar)
    }
    
    @objc func onDoneButtonTapped() {
        pickerToolBar.removeFromSuperview()
        currencyPicker.removeFromSuperview()
    }
}

extension CurrenciesViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.otherCurrencies?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currecyCell = tableView.dequeueReusableCell(withIdentifier: currencyCellID, for: indexPath) as? CurrencyCellView else {
            preconditionFailure("Invalid cell type")
        }
        if indexPath.section > 0 {
            currecyCell.currency = self.otherCurrencies?[indexPath.row]
            currecyCell.currencyRateLabel.isHidden = false
        } else {
            currecyCell.currency = self.baseCurrency
            currecyCell.currencyRateLabel.isHidden = true
        }
        return currecyCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.section > 0 {
            let converterViewController = CurrencyConverterViewController()
            converterViewController.baseCurrency = self.baseCurrency
            converterViewController.otherCurrency = self.otherCurrencies?[indexPath.item]
            self.navigationController?.pushViewController(converterViewController, animated: true)
        } else {
            self.createPickersAndToolbar()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
}

extension CurrenciesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.otherCurrencies?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow pickerRow: Int, forComponent component: Int) -> String? {
        if let code = self.otherCurrencies?[pickerRow].code, !code.isEmpty {
            return "\(Utility.emojiFlag(currencyCode: code)) \(code)"
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow pickerRow: Int, inComponent component: Int) {
        let baseCurrencyCode = self.otherCurrencies?[pickerRow].code ?? ""
        self.baseCurrency = self.otherCurrencies?[pickerRow]
        self.refresh(for: baseCurrencyCode)
    }
}
