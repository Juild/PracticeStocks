//
//  StocksRepo.swift
//  PracticeStocks
//
//  Created by Jc on 16/8/23.
//

import Foundation
import os


protocol StocksRepositoryProtocol {
    static func getStockBySymbol(id: String, completion: @escaping (Result<StockQueryResult.Stock, Error>) -> Void)
    static func searchStocksByKeywords(keywords: String, completion: @escaping (Result<[StockSearchResult.StockSearchItem], Error>) -> Void)
    static func getPriceData(symbol: String, completion: @escaping (Result<StockTimeSeriesResponse, Error>) -> Void)
    static func getStockOverview(symbol: String, completion: @escaping (Result<StockOverview, Error>) -> Void)
    
}

enum StocksRepositoryError: Error {
    case apiKeyMissing
    case invalidURL
    case invalidResponse
}

struct StocksRepository: StocksRepositoryProtocol {
    
    
    static let apiKey = ProcessInfo.processInfo.environment["API_KEY"]
    static let queryEndpoint = "https://www.alphavantage.co/query"
    
    
    static func getStockOverview(symbol: String, completion: @escaping (Result<StockOverview, Error>) -> Void) {
        guard Self.apiKey != nil else {
            completion(.failure(StocksRepositoryError.apiKeyMissing))
            return
        }
        
        guard var urlComponents = URLComponents(string: Self.queryEndpoint) else {
            completion(.failure(StocksRepositoryError.invalidURL))
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "symbol", value: symbol),
            URLQueryItem(name: "function", value: "OVERVIEW"),
            URLQueryItem(name: "apikey", value: apiKey)
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(StocksRepositoryError.invalidURL))
            return
        }
        
        let task =  URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                do {
                    let stockOverview = try JSONDecoder().decode(StockOverview.self, from: data)
                    completion(.success(stockOverview))
                } catch {
                    completion(.failure(StocksRepositoryError.invalidResponse))
                    print("error decoding into [Stock.self] \(error)")
                }
                
                
            }
            
        }
        task.resume()
        
    }
    
    static func getStockBySymbol(id: String, completion: @escaping (Result<StockQueryResult.Stock, Error>) -> Void) {
        guard Self.apiKey != nil else {
            completion(.failure(StocksRepositoryError.apiKeyMissing))
            return
        }
        
        guard var urlComponents = URLComponents(string: Self.queryEndpoint) else {
            completion(.failure(StocksRepositoryError.invalidURL))
            return
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "symbol", value: id),
            URLQueryItem(name: "function", value: "GLOBAL_QUOTE"),
            URLQueryItem(name: "apikey", value: apiKey)
        ]
        guard let url = urlComponents.url else {
            completion(.failure(StocksRepositoryError.invalidURL))
            return
        }
        
        
        let task =  URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                do {
                    print("Response\(try JSONSerialization.jsonObject(with: data, options: []))")
                    let stock = try JSONDecoder().decode(StockQueryResult.self, from: data)
                    completion(.success(stock.stock))
                } catch {
                    
                    completion(.failure(StocksRepositoryError.invalidResponse))
                    print("error decoding into [Stock.self] \(error)")
                }
                
                
            }
            
        }
        task.resume()
    }
    static func searchStocksByKeywords(keywords: String, completion: @escaping (Result<[StockSearchResult.StockSearchItem], Error>) -> Void) {
        guard Self.apiKey != nil else {
            completion(.failure(StocksRepositoryError.apiKeyMissing))
            return
        }
        
        guard var urlComponents = URLComponents(string: Self.queryEndpoint) else {
            completion(.failure(StocksRepositoryError.invalidURL))
            return
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "function", value: "SYMBOL_SEARCH"),
            URLQueryItem(name: "keywords", value: keywords),
            URLQueryItem(name: "datatype", value: "json"),
            URLQueryItem(name: "apikey", value: apiKey)
        ]
        guard let url = urlComponents.url else {
            completion(.failure(StocksRepositoryError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                do {
                    print("Response\(try JSONSerialization.jsonObject(with: data, options: []))")
                    let searchResult = try JSONDecoder().decode(StockSearchResult.self, from: data)
                    completion(.success(searchResult.bestMatches))
                } catch {
                    completion(.failure(StocksRepositoryError.invalidResponse))
                    print("Error decoding search result: \(error)")
                }
            }
        }
        task.resume()
    }
    
    static func getPriceData(symbol: String, completion: @escaping (Result<StockTimeSeriesResponse, Error>) -> Void) {
        guard let apiKey = apiKey else {
            completion(.failure(StocksRepositoryError.apiKeyMissing))
            return
        }
        
        guard var urlComponents = URLComponents(string: queryEndpoint) else {
            completion(.failure(StocksRepositoryError.invalidURL))
            return
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "symbol", value: symbol),
            URLQueryItem(name: "function", value: "TIME_SERIES_DAILY"),
            URLQueryItem(name: "apikey", value: apiKey)
        ]
        guard let url = urlComponents.url else {
            completion(.failure(StocksRepositoryError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                do {
                    print("Response\(try JSONSerialization.jsonObject(with: data, options: []))")
                    let json = try JSONDecoder().decode(StockTimeSeriesResponse.self, from: data)
                    completion(.success(json))
                } catch {
                    completion(.failure(error))
                    print("Error decoding daily price data: \(error)")
                }
            }
        }
        task.resume()
    }
    
}
