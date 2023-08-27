//
//  ContentView.swift
//  PracticeStocks
//
//  Created by Jc on 15/8/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 60) {
                    Section(header: Text("Funds").font(.title).bold()){
                        Text("\(viewModel.funds)€")
                            .font(.system(size: 60))
                    }
                    HStack(spacing: 60) {
                        Button("Add") {
                            viewModel.addWithdrawFundsPressed(action: FundsAction.add)
                        }
                        .buttonStyle(AppButtonStyle())
                        .sheet(isPresented: $viewModel.isFundsSheetPresented) {
                            AddWithdrawFundsView()
                            
                        }
                        Button("Withdraw") {
                            viewModel.addWithdrawFundsPressed(action: .withdraw)
                        }
                        .buttonStyle(AppButtonStyle())
                        .sheet(isPresented: $viewModel.isFundsSheetPresented) {
                            AddWithdrawFundsView()
                        }
                        
                    }
                    .environmentObject(viewModel)
                    Section(header:
                                HStack
                            {
                        Text("Favorite Stocks")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    ) {
                        Button {
                            viewModel.searchForStockPressed()
                        } label: {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                Text("Add Stocks")
                            }
                        }
                        .sheet(isPresented: $viewModel.isSearchSheetPresented) {
                            NavigationView {
                                StockListView()
                                    .environmentObject(viewModel)
                            }
                            .navigationTitle("Stocks")
                        }
                    }
                    
                    
                    
                    
                }
                
                .padding([.vertical, .horizontal])
                .navigationTitle("Report")
                StocksVStack()
                    .padding()
                    .environmentObject(viewModel)
                
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
}
