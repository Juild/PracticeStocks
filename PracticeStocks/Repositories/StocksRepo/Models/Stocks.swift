//
//  StocksModel.swift
//  PracticeStocks
//
//  Created by Jc on 16/8/23.
//

import Foundation

struct StockQueryResult: Codable {
    
    struct Stock: Codable, Equatable, Model {
        typealias VM = StockVM
        
        func toVM() -> StockVM {
            StockVM(symbol: symbol, currentPrice: currentPrice)
        }
        
        let symbol: String
        var priceHistory: [Float]?
        var currentPrice: String
        
        init(symbol: String, priceHistory: [Float]?, currentPrice: String) {
            self.symbol = symbol
            self.priceHistory = priceHistory
            self.currentPrice = currentPrice
        }

        
        enum CodingKeys: String, CodingKey {
            case symbol =  "01. symbol"
            case currentPrice = "05. price"
        }
        
        static func ==(lhs: Stock, rhs: Stock) -> Bool {
            return lhs.symbol == rhs.symbol
        }
        
    }
    let stock: Stock
     
    enum CodingKeys: String, CodingKey {
        case stock = "Global Quote"
    }
}


