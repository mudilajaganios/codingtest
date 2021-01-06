//
//  DataFixerAPI.swift
//  Currency Converter
//
//  Created by Jagan Kumar Mudila on 06/01/2021.
//

import Foundation

class DataFixerAPI {
    
    let apiBasePath = "http://data.fixer.io/api/"
    let apiKey = "a274431bcb6fbd60daf2d57d3d8e57a3"
    
    static let instance = DataFixerAPI()
    
    private init() {
        
    }
    
    func getCurrencies(for baseRate: String) {
        let params = ["access_key": self.apiKey,
                      "base": baseRate]
        self.getRequest(contract: "latest", parameters: params) {
            
        }
    }
    
    func convert(baseCurrency: String, desiredCurrency: String, amount: Double) {
        let params = ["access_key": self.apiKey,
                      "from": baseCurrency,
                      "to": desiredCurrency,
                      "amount": "\(amount)"]
        self.getRequest(contract: "latest", parameters: params) {
            
        }
    }
    
    fileprivate func getRequest(contract: String,
                                parameters: [String: String]?,
                                completion: @escaping() -> Void) {
        guard let url = URL(string: self.apiBasePath + contract) else { return }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        if let parameters = parameters {
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        var httpRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        httpRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: httpRequest) { (data, response, error) in
            
        }.resume()
    }
}
