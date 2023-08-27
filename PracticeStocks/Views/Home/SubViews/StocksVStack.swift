//
//  StocksVStack.swift
//  PracticeStocks
//
//  Created by Jc on 17/8/23.
//

import SwiftUI

struct StocksVStack: View {
    @EnvironmentObject var viewModel: HomeView.ViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(viewModel.favoriteStocks, id: \.symbol) { stock in
                HStack(spacing: 20) {
                    Button {

                            viewModel.removeStock(stock: stock)
                    } label: {
                        if viewModel.favoriteStocks.contains(stock) {
                            Image(systemName: "plus.circle.fill")
                        } else {
                            Image(systemName: "plus.circle")
                        }
                    }
                    .buttonStyle(.borderless)

                    NavigationLink(destination: DetailsView(viewModel: DetailsView.ViewModel(symbol: stock.symbol))) {
                        VStack(alignment: .leading) {
                            Text(stock.symbol)
                                .font(.headline)
                            Text("Current Price: \(stock.currentPrice)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                Divider()
            }
        }

    }
}

struct StocksVStack_Previews: PreviewProvider {
    // static var viewModel: HomeView.ViewModel = HomeView.ViewModel(funds: 100, favoriteStocks: [StockQueryResult.Stock(symbol: "AAPL", priceHistory: nil, currentPrice: "150.00"), StockQueryResult.Stock(symbol: "GOOGL", priceHistory: nil, currentPrice: "170.00")])
    static var viewModel = HomeView.ViewModel()
    static var previews: some View {
        StocksVStack().environmentObject(viewModel)
    }
}
