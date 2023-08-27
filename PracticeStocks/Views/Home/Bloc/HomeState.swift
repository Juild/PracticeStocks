//
//  HomeState.swift
//  PracticeStocks
//
//  Created by Jc on 16/8/23.
//

import Foundation

enum HomeStateNew {
    case MainPage(funds: Int, stocksSelected: [StockVM])
    case FundsEditor(action: FundsAction)
    case SearchModal
}
