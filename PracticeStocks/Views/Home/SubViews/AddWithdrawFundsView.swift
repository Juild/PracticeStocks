//
//  AddWithdrawFundsView.swift
//  PracticeStocks
//
//  Created by Jc on 15/8/23.
//

import SwiftUI

struct AddWithdrawFundsView: View {
    @EnvironmentObject var viewModel: HomeView.ViewModel
    @FocusState var focused: Bool
    @State var amount = ""
    var body: some View {
        VStack {
            TextField("Enter amount to \(viewModel.action!.rawValue)", text: $amount)
                .multilineTextAlignment(.center)
                .padding()
                .keyboardType(.numberPad)
                .focused($focused)
                .onAppear {
                    self.focused = true
                }
            Button(viewModel.action!.rawValue) {
                viewModel.isFundsSheetPresented.toggle()
                viewModel.submitAddWithdrawFunds(amount: Int(amount)!)
            }
            .buttonStyle(AppButtonStyle())
            
            .padding()
            
            
        }
        
        
    }
}

struct AddWithdrawFundsView_Previews: PreviewProvider {
    static var previews: some View {
        AddWithdrawFundsView()
    }
}
