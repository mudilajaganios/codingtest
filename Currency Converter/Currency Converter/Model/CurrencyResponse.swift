//
//  CurrencyResponse.swift
//  Currency Converter
//
//  Created by Jagan Kumar Mudila on 06/01/2021.
//

import Foundation

struct CurrencyResponse: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}
