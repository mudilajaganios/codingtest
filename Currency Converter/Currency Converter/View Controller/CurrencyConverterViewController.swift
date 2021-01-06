//
//  CurrencyConverterViewController.swift
//  Currency Converter
//
//  Created by Jagan Kumar Mudila on 06/01/2021.
//

import UIKit

class CurrencyConverterViewController: UITableViewController {
    
    let currencyCellID = "currencyCell"
    
    var baseCurrency: Currency! {
        didSet {
            
        }
    }
    
    var otherCurrencies: [Currency]! {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Bar
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 63/255.0, green: 149/255.0, blue: 244/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = "Currency Converter"
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: currencyCellID)
        
        DataFixerAPI.instance.getCurrencies(for: "")
    }
    
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
        guard let currecyCell = tableView.dequeueReusableCell(withIdentifier: currencyCellID, for: indexPath) as? UITableViewCell else {
            preconditionFailure("Invalid cell type")
        }
        
        return currecyCell
    }
}
