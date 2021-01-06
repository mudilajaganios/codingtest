//
//  Utility.swift
//  Currency Converter
//
//  Created by Jagan Kumar Mudila on 06/01/2021.
//

import Foundation

class Utility {
    //Grabbed from internet and modified
    static func emojiFlag(currencyCode: String) -> String {
        var string = ""
        var countryCode = currencyCode
        let base : UInt32 = 127397
        countryCode.removeLast(1)
        for uS in countryCode.unicodeScalars {
            if let us = UnicodeScalar(base + uS.value) {
                string.unicodeScalars.append(us)
            }
        }
        return string
    }
}
