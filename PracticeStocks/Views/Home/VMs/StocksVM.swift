//
//  StocksViewModel.swift
//  PracticeStocks
//
//  Created by Jc on 16/8/23.
//

import Foundation


struct StockVM: Equatable, Hashable {
    let symbol: String
    let currentPrice: String
    
    static func ==(lhs: StockVM, rhs: StockVM) -> Bool {
        return lhs.symbol == rhs.symbol
    }
}
