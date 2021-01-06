//
//  CurrencyResponse.swift
//  Currency Converter
//
//  Created by Jagan Kumar Mudila on 06/01/2021.
//

import Foundation

protocol ResponseBase: Codable {
    var success: Bool { get }
    var error: ResponseError? { get }
}

// MARK: - Error
struct ResponseError: Codable {
    let code: Int
    let type, info: String
}

struct CurrencyResponse: ResponseBase {
    var success: Bool
    var error: ResponseError?
    let timestamp: Int?
    let base, date: String?
    let rates: [String: Double]?
}
