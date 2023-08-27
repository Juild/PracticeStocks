//
//  StockOverviewVM.swift
//  PracticeStocks
//
//  Created by Jc on 25/8/23.
//

import Foundation

struct StockOverviewVM {
    let symbol, assetType, name, description: String
    let cik, exchange, currency, country: String
    let sector, industry, address, fiscalYearEnd: String
    let latestQuarter, marketCapitalization, ebitda, peRatio: String
    let pegRatio, bookValue, dividendPerShare, dividendYield: String
    
    
    
    static func defaultStockOverviewVM() -> Self {
        return StockOverviewVM(symbol: "", assetType: "", name: "", description: "", cik: "", exchange: "", currency: "", country: "", sector: "", industry: "", address: "", fiscalYearEnd: "", latestQuarter: "", marketCapitalization: "", ebitda: "", peRatio: "", pegRatio: "", bookValue: "", dividendPerShare: "", dividendYield: "")
    }
    
    func toDict() -> [String:String] {
            var dict = [String:String]()
            let otherSelf = Mirror(reflecting: self)
            for child in otherSelf.children {
                if let key = child.label {
                    dict[camelCaseToNaturalLanguage(key)] = String(describing: child.value)
                }
            }
            return dict
        }
    
}
