//
//  HomeModel.swift
//  PracticeStocks
//
//  Created by Jc on 15/8/23.
//

import Foundation

enum FundsAction: CustomStringConvertible {
    case add
    case withdraw
    
    var description: String {
        switch self {
        case .add:
            return "Add"
        case .withdraw:
            return "Withdraw"
        }
    }
}

class HomeState: ObservableObject {
    @Published var funds: Int
    @Published var text = ""
    @Published var isPresented = false
    @Published var action: FundsAction
    
    init(funds: Int = 200, isPresented: Bool = false, action: FundsAction = .add, text: String = ""){
        self.funds = funds
        self.isPresented = isPresented
        self.text = text
        self.action = action
    }
    
    func incrementFunds(increase: Int) -> Void {
        self.funds += increase
    }
    
    func decrementFunds(decrement: Int) -> Void {
        self.funds -= decrement
    }
    func getSymbolCurrentPrice(symbol: String) {
        StocksRepository.getStockBySymbol(id: "GOOGL") { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let stock):
                print(stock)
            }
        }
    }
}

class HomeBloc: ObservableObject {
    // Should be retrieved from a repository
    private var funds: Int = 200
    private var stocksSelected: [StockVM] = []
    @Published var state: HomeStateNew
    
    init() {
        state = .MainPage(funds: self.funds, stocksSelected: stocksSelected)
    }
    
    var event: HomeEvent? {
        didSet {
            switch event {
            case .addPressed:
                state = .FundsEditor(action: .add)
            case .withdrawPressed:
                state = .FundsEditor(action: .withdraw)
            case .none:
                state = state
            case .increaseFunds(let amount):
                state = .MainPage(funds: funds + amount, stocksSelected: stocksSelected)
            case .decreaseFunds(let amount):
                let finalAmount = funds - amount
                if finalAmount >= 0 {
                    state = .MainPage(funds: finalAmount, stocksSelected: stocksSelected)
                } else {
                    print("subtracting the specified amount would result in negative balance")
                    state = .MainPage(funds: funds, stocksSelected: stocksSelected)
                }
            case .searchStockPressed:
                state = .SearchModal
            case .addStockPressed(let stockVM):
                stocksSelected.append(stockVM)
                state = .MainPage(funds: funds, stocksSelected: stocksSelected)
            
            }
        }
    }
    
    func getSymbolCurrentPrice(symbol: String) {
        StocksRepository.getStockBySymbol(id: symbol) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let stock):
                print(stock)
                let stockVM = stock.toVM()
            }
        }
    }
}
