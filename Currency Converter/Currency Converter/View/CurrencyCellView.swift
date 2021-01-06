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
            if let code = currency?.code, !code.isEmpty {
                self.currencyCodeLabel.text = "\(Utility.emojiFlag(currencyCode: code)) \(code)"
            }
            self.currencyRateLabel.text = ""
            if let currencyRate = currency?.rate {
                self.currencyRateLabel.text = String(format: "%.2f", currencyRate)
            }
        }
    }
    
    lazy var currencyCodeLabel: UILabel = {
        let currencyCode = UILabel()
        currencyCode.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        currencyCode.textAlignment = .left
        currencyCode.textColor = .darkGray
        currencyCode.translatesAutoresizingMaskIntoConstraints = false
        return currencyCode
    }()

    lazy var currencyRateLabel: UILabel = {
        let currencyRate = UILabel()
        currencyRate.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        currencyRate.textAlignment = .right
        currencyRate.textColor = .darkGray
        currencyRate.translatesAutoresizingMaskIntoConstraints = false
        return currencyRate
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(currencyCodeLabel)
        self.contentView.addSubview(currencyRateLabel)
        
        NSLayoutConstraint.activate([
            currencyCodeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24.0),
            currencyCodeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5.0),
            currencyCodeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5.0),
            currencyCodeLabel.trailingAnchor.constraint(equalTo: self.currencyRateLabel.leadingAnchor, constant: -20.0),
            currencyRateLabel.widthAnchor.constraint(equalToConstant: 100.0),
            currencyRateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24.0),
            currencyRateLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
        
        self.selectionStyle = .default
        self.accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
