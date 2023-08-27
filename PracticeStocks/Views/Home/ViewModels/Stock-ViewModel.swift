//
//  Stock-ViewModel.swift
//  PracticeStocks
//
//  Created by Jc on 22/8/23.
//

import Foundation

struct StockVM: Codable, Equatable {
    let symbol: String
    let currentPrice: String
    
    static func ==(lhs: StockVM, rhs: StockVM) -> Bool {
        return lhs.symbol == rhs.symbol
    }
}
