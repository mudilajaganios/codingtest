//
//  ConversionResponse.swift
//  Currency Converter
//
//  Created by Jagan Kumar Mudila on 06/01/2021.
//

import Foundation

struct ConversionResponse: Codable {
    let success: Bool
    let info: Info
    let date: String
    let result: Double
}

struct Info: Codable {
    let timestamp: Int
    let rate: Double
}
