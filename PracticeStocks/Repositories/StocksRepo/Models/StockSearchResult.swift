//
//  StockSearchItems.swift
//  PracticeStocks
//
//  Created by Jc on 21/8/23.
//

import Foundation

struct StockSearchResult: Codable{
    struct StockSearchItem: Codable, Equatable {

        let symbol: String
        let name: String
        let type: String
        let region: String
        let marketOpen: String
        let marketClose: String
        let timezone: String
        let currency: String
        let matchScore: String
        
        private enum CodingKeys: String, CodingKey {
            case symbol = "1. symbol"
            case name = "2. name"
            case type = "3. type"
            case region = "4. region"
            case marketOpen = "5. marketOpen"
            case marketClose = "6. marketClose"
            case timezone = "7. timezone"
            case currency = "8. currency"
            case matchScore = "9. matchScore"
        }
        static func ==(lhs: StockSearchResult.StockSearchItem, rhs: StockSearchResult.StockSearchItem) -> Bool {
            return lhs.symbol == rhs.symbol
        }
        
    }
    
    let bestMatches: [StockSearchItem]
    
    
}
