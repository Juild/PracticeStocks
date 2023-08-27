//
//  TimeSeriesPlotView.swift
//  PracticeStocks
//
//  Created by Jc on 23/8/23.
//

import SwiftUI
import Charts
import Foundation

struct LinePlotView: View {
    @EnvironmentObject var viewModel: DetailsView.ViewModel
    
    var body: some View {
        Chart(viewModel.dataPoints, id: \.id) {
            PointMark(
                x: .value("Day", $0.id),
                y: .value("Price", $0.price)
            )
        }
        .chartYAxis {
            AxisMarks(position: .trailing)
        }
        .frame(minHeight: 300)
        
    }
    
}

struct DetailsView: View {
    @StateObject var viewModel: DetailsView.ViewModel
    var body: some View {
        
        
        ScrollView {
            VStack {
                HStack {
                    Text(viewModel.symbol)
                        .font(.title)
                        .bold()
                    Spacer()
                }
                LinePlotView()
                    .environmentObject(viewModel)
                    .padding()
                
                
                HStack {
                    Section(
                        header: Text("Overview")
                            .font(.title)
                            .bold()
                    ) {
                        
                    }
                    Spacer()
                }
                .padding([.vertical])
                ForEach(Array(viewModel.stockOverview.toDict()), id: \.key) { key, value in
                    
                    
                    
                    HStack{
                        Section(
                            header: Text("\(key)")
                                .font(.title2)
                                .bold()
                        ) {
                            
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Text("\(value)")
                        Spacer()
                        
                    }
                    
                    .padding([.vertical])
                    
                    
                }
                
                
                
                
            }
            .padding()
            
        }
        
        
        
        
    }
}


struct TimeSeriesPlotView_Previews: PreviewProvider {
    static let  dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    static let sampleData: [SeriesVM] =  [
        SeriesVM(id: dateFormatter.date(from: "2023-08-01")!, price: 123.45),
        SeriesVM(id: dateFormatter.date(from: "2023-08-02")!, price: 128.20),
        SeriesVM(id: dateFormatter.date(from: "2023-08-03")!, price: 130.75),
        SeriesVM(id: dateFormatter.date(from: "2023-08-04")!, price: 135.60),
        SeriesVM(id: dateFormatter.date(from: "2023-08-05")!, price: 142.30),
        SeriesVM(id: dateFormatter.date(from: "2023-08-06")!, price: 137.80),
        SeriesVM(id: dateFormatter.date(from: "2023-08-07")!, price: 148.90),
        SeriesVM(id: dateFormatter.date(from: "2023-08-08")!, price: 155.40),
        SeriesVM(id: dateFormatter.date(from: "2023-08-09")!, price: 160.25),
        SeriesVM(id: dateFormatter.date(from: "2023-08-10")!, price: 163.70),
        SeriesVM(id: dateFormatter.date(from: "2023-08-11")!, price: 158.15),
        SeriesVM(id: dateFormatter.date(from: "2023-08-12")!, price: 152.80),
        SeriesVM(id: dateFormatter.date(from: "2023-08-13")!, price: 147.60),
        SeriesVM(id: dateFormatter.date(from: "2023-08-14")!, price: 143.90),
        SeriesVM(id: dateFormatter.date(from: "2023-08-15")!, price: 139.50),
        SeriesVM(id: dateFormatter.date(from: "2023-08-16")!, price: 134.75),
        SeriesVM(id: dateFormatter.date(from: "2023-08-17")!, price: 130.20),
        SeriesVM(id: dateFormatter.date(from: "2023-08-18")!, price: 126.85),
        SeriesVM(id: dateFormatter.date(from: "2023-08-19")!, price: 122.70),
        SeriesVM(id: dateFormatter.date(from: "2023-08-20")!, price: 118.90)
        
    ]
    
    static var viewModel = DetailsView.ViewModel(symbol: "GOOGL")
    static var previews: some View {
        DetailsView(viewModel: viewModel)
    }
}
