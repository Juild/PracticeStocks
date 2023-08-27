//
//  StocksView-ViewModel.swift
//  PracticeStocks
//
//  Created by Jc on 23/8/23.
//

import Foundation

extension DetailsView {
    @MainActor class ViewModel: ObservableObject {
        let symbol: String
        @Published var dataPoints: [SeriesVM]
        @Published var stockOverview: StockOverviewVM
        
        init(symbol: String) {
            self.symbol = symbol
            self.dataPoints = []
            self.stockOverview = StockOverviewVM.defaultStockOverviewVM()
            getStockPriceData(symbol: symbol)
            StocksRepository.getStockOverview(symbol: symbol)  { result in
                switch result {
                case .success(let stockOverview):
                    DispatchQueue.main.async { self.stockOverview = stockOverview.toVM() }
                case .failure(let error):
                    print("error \(error)")
                }
            
            }
        }

        func getStockPriceData(symbol: String) {
             StocksRepository.getPriceData(symbol: symbol ) { result in
                switch result {
                case .failure(let error):
                    print("Error \(error)")
                case .success(let response ):
                    for (date, priceStats) in response.timeSeries {
                            DispatchQueue.main.async {
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyy-MM-dd"
                                let seriesVM = SeriesVM(id: dateFormatter.date(from: date)!, price: Float(priceStats.close)!)
                                self.dataPoints.append(seriesVM)
                            }
                        
                    }
                }
            }
        }
    }
}
