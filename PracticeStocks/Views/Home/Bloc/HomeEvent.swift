//
//  HomeEvent.swift
//  PracticeStocks
//
//  Created by Jc on 16/8/23.
//

import Foundation

enum HomeEvent {
    case addPressed
    case withdrawPressed
    case increaseFunds(amount: Int)
    case decreaseFunds(amount: Int)
    case searchStockPressed
    case addStockPressed(stock: StockVM)
}
