//
//  StockOverviewModel.swift
//  PracticeStocks
//
//  Created by Jc on 25/8/23.
//

import Foundation

struct StockOverview: Codable, Model {
    typealias VM = StockOverviewVM
    
    func toVM() -> VM {
        StockOverviewVM(symbol: symbol, assetType: assetType, name: name, description: description, cik: cik, exchange: exchange, currency: currency, country: country, sector: sector, industry: industry, address: address, fiscalYearEnd: fiscalYearEnd, latestQuarter: latestQuarter, marketCapitalization: marketCapitalization, ebitda: ebitda, peRatio: peRatio, pegRatio: pegRatio, bookValue: bookValue, dividendPerShare: dividendPerShare, dividendYield: dividendYield)
    }
    
    let symbol, assetType, name, description: String
    let cik, exchange, currency, country: String
    let sector, industry, address, fiscalYearEnd: String
    let latestQuarter, marketCapitalization, ebitda, peRatio: String
    let pegRatio, bookValue, dividendPerShare, dividendYield: String
    let eps, revenuePerShareTTM, profitMargin, operatingMarginTTM: String
    let returnOnAssetsTTM, returnOnEquityTTM, revenueTTM, grossProfitTTM: String
    let dilutedEPSTTM, quarterlyEarningsGrowthYOY, quarterlyRevenueGrowthYOY, analystTargetPrice: String
    let trailingPE, forwardPE, priceToSalesRatioTTM, priceToBookRatio: String
    let evToRevenue, evToEBITDA, beta, the52WeekHigh: String
    let the52WeekLow, the50DayMovingAverage, the200DayMovingAverage, sharesOutstanding: String
    let dividendDate, exDividendDate: String

    enum CodingKeys: String, CodingKey {
        case symbol = "Symbol"
        case assetType = "AssetType"
        case name = "Name"
        case description = "Description"
        case cik = "CIK"
        case exchange = "Exchange"
        case currency = "Currency"
        case country = "Country"
        case sector = "Sector"
        case industry = "Industry"
        case address = "Address"
        case fiscalYearEnd = "FiscalYearEnd"
        case latestQuarter = "LatestQuarter"
        case marketCapitalization = "MarketCapitalization"
        case ebitda = "EBITDA"
        case peRatio = "PERatio"
        case pegRatio = "PEGRatio"
        case bookValue = "BookValue"
        case dividendPerShare = "DividendPerShare"
        case dividendYield = "DividendYield"
        case eps = "EPS"
        case revenuePerShareTTM = "RevenuePerShareTTM"
        case profitMargin = "ProfitMargin"
        case operatingMarginTTM = "OperatingMarginTTM"
        case returnOnAssetsTTM = "ReturnOnAssetsTTM"
        case returnOnEquityTTM = "ReturnOnEquityTTM"
        case revenueTTM = "RevenueTTM"
        case grossProfitTTM = "GrossProfitTTM"
        case dilutedEPSTTM = "DilutedEPSTTM"
        case quarterlyEarningsGrowthYOY = "QuarterlyEarningsGrowthYOY"
        case quarterlyRevenueGrowthYOY = "QuarterlyRevenueGrowthYOY"
        case analystTargetPrice = "AnalystTargetPrice"
        case trailingPE = "TrailingPE"
        case forwardPE = "ForwardPE"
        case priceToSalesRatioTTM = "PriceToSalesRatioTTM"
        case priceToBookRatio = "PriceToBookRatio"
        case evToRevenue = "EVToRevenue"
        case evToEBITDA = "EVToEBITDA"
        case beta = "Beta"
        case the52WeekHigh = "52WeekHigh"
        case the52WeekLow = "52WeekLow"
        case the50DayMovingAverage = "50DayMovingAverage"
        case the200DayMovingAverage = "200DayMovingAverage"
        case sharesOutstanding = "SharesOutstanding"
        case dividendDate = "DividendDate"
        case exDividendDate = "ExDividendDate"
    }
}
