//
//  CurrencyConversionCell.swift
//  Currency Converter
//
//  Created by Jagan Kumar Mudila on 06/01/2021.
//

import UIKit

protocol CurrencyConversionCellDelegate {
    func convertCurrencies(baseCode: String, amount: String)
}

class CurrencyConversionCell: UITableViewCell {
    
    var oldValue: String?
    
    var delegate: CurrencyConversionCellDelegate?
    
    var currency: Currency! {
        didSet {
            self.currencyCodeLabel.text = ""
            self.currencyInput.text = "1"
            if let code = currency?.code, !code.isEmpty {
                self.currencyCodeLabel.text = "\(Utility.emojiFlag(currencyCode: code)) \(code)"
            }
            
            if let currencyRate = currency?.rate {
                self.currencyInput.text = "\(currencyRate)"
            }
        }
    }
    
    lazy var currencyInput: UITextField = {
        let input = UITextField()
        input.delegate = self
        input.keyboardType = .decimalPad
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    lazy var currencyCodeLabel: UILabel = {
        let currencyCode = UILabel()
        currencyCode.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        currencyCode.textAlignment = .center
        currencyCode.textColor = .darkGray
        currencyCode.translatesAutoresizingMaskIntoConstraints = false
        return currencyCode
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(currencyInput)
        self.contentView.addSubview(currencyCodeLabel)
        
        NSLayoutConstraint.activate([
            currencyInput.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24.0),
            currencyInput.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5.0),
            currencyInput.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5.0),
            currencyInput.trailingAnchor.constraint(equalTo: self.currencyCodeLabel.leadingAnchor, constant: -20.0),
            currencyCodeLabel.widthAnchor.constraint(equalToConstant: 100.0),
            currencyCodeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24.0),
            currencyCodeLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
        
        self.selectionStyle = .none
        
//        self.currencyInput.addInputAccessoryView(title: "Done", target: self, selector: #selector(endTextEditing))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrencyConversionCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.oldValue = textField.text
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let newValue = textField.text,
           !newValue.isEmpty,
           self.oldValue != newValue {
            self.delegate?.convertCurrencies(baseCode: self.currency.code, amount: newValue)
        } else if textField.text?.isEmpty ?? false {
            textField.text = self.oldValue
        }
    }
}
