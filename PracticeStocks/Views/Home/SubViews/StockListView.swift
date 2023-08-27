//
//  StockListRow.swift
//  PracticeStocks
//
//  Created by Jc on 16/8/23.
//

import SwiftUI

struct StockListView: View {
    @EnvironmentObject var viewModel: HomeView.ViewModel
    var body: some View {
        
        NavigationView
        {
            List(viewModel.searchResults, id: \.symbol) { stock in
                HStack(spacing: 20) {
                    Button {
                        viewModel.addStock(stock: stock)
                        
                    } label: {
                        if viewModel.favoriteStocksContains(stock: stock) {
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

                        }
                    }
                    
                    
                    
                }
                
                
            }
            .scrollContentBackground(.visible)
            .navigationTitle("Search Stocks")
        }
        .searchable(text: $viewModel.searchText)
        

        
        
        
    }
}

struct StockListView_Previews: PreviewProvider {
   // static var viewModel: HomeView.ViewModel = HomeView.ViewModel(funds: 100, favoriteStocks: [StockQueryResult.Stock(symbol: "AAPL", priceHistory: nil, currentPrice: "150.00"),])
    static var viewModel = HomeView.ViewModel()
    static var previews: some View {
       
        StockListView().environmentObject(viewModel)
    }
}
