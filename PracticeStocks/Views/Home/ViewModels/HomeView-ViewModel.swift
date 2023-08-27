//
//  HomeView-ViewModel.swift
//  PracticeStocks
//
//  Created by Jc on 17/8/23.
//

import Foundation

enum FundsAction: String {
    case add = "Add"
    case withdraw = "Withdraw"
}

extension HomeView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var funds: Int { didSet { UserDefaults.standard.set(self.funds, forKey: "funds") } }
        @Published var favoriteStocks: [StockVM] { didSet { saveFavoriteStocks() } }
        @Published var isFundsSheetPresented: Bool = false
        @Published var isSearchSheetPresented: Bool = false {
            didSet {
                if !isSearchSheetPresented {
                    self.searchResults = []
                    self.searchText = ""
                }
            }
        }
        @Published var action: FundsAction? = .none
        @Published var searchResults: [StockSearchResult.StockSearchItem] = []
        @Published var searchText: String = "" { didSet { onSearchTextChanged() } }
        
        init() {
            if let encodedData = UserDefaults.standard.data(forKey: "favoriteStocks") {
                do {
                    let decodedData = try JSONDecoder().decode([StockVM].self, from: encodedData)
                    print(decodedData)
                    favoriteStocks = decodedData
                } catch {
                    fatalError("Error loading favoriteStocks: \(error)")
                }
            } else {
                print("favorite stocks nil")
                favoriteStocks = []
            }
            
            funds = UserDefaults.standard.integer(forKey: "funds")
                                
            
        }
        
        private func saveFavoriteStocks() {
            do {
                let encodedData = try JSONEncoder().encode(favoriteStocks)
                UserDefaults.standard.set(encodedData, forKey: "favoriteStocks")
                print("Stocks saved")
            } catch {
                print("Error saving favoriteStocks: \(error)")
            }
        }
        
        
        
        
        
        func addWithdrawFundsPressed(action: FundsAction) {
            self.action = action
            isFundsSheetPresented.toggle()
        }
        func submitAddWithdrawFunds(amount: Int) {
            switch action {
            case .add:
                funds += amount
                
            case .withdraw:
                
                if funds - amount >= 0 {
                    funds -= amount
                } else{
                    print("not enough funds to withdraw the specified amount")
                }
                
            case .none:
                return
            }
        }
        func searchForStockPressed() {
            isSearchSheetPresented.toggle()
            
        }
        func addStock(stock: StockSearchResult.StockSearchItem) {
            
            StocksRepository.getStockBySymbol(id: stock.symbol) { result in
                switch result {
                case .failure(let error):
                    print("Error getting stock by symbol id \(error)")
                case .success(let stock):
                    print(stock)
                    self.favoriteStocks.append(stock.toVM())
                }
            }
            
        }
        func removeStock(stock: StockVM) {
            print("element to remove \(stock)")
            favoriteStocks.removeAll { element in
                return element == stock
            }
        }
        func onSearchTextChanged() {
            if !self.searchText.isEmpty {
                StocksRepository.searchStocksByKeywords(keywords: self.searchText) { result in
                    switch result {
                    case .success(let searchResults):
                        DispatchQueue.main.async { self.searchResults = searchResults }
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            }
        }
        func favoriteStocksContains(stock: StockSearchResult.StockSearchItem) -> Bool {
            let symbol = stock.symbol
            let stock  = StockVM(symbol: symbol, currentPrice: "")
            return self.favoriteStocks.contains(stock)
        }
    }
}
