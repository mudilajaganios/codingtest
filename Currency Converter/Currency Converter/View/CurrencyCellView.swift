//
//  CurrencyCellView.swift
//  Currency Converter
//
//  Created by Jagan Kumar Mudila on 06/01/2021.
//

import UIKit

class CurrencyCellView: UITableViewCell {
    
    var currency: Currency! {
        didSet {
            self.textLabel?.text = currency.code
            if let currencyRate = currency.rate {
                self.detailTextLabel?.text = "\(currencyRate)"
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
