//
//  AppButtonView.swift
//  PracticeStocks
//
//  Created by Jc on 22/8/23.
//

import SwiftUI

struct AppButtonStyle: ButtonStyle {
    let vPadding = 12.0
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, vPadding)
            .padding(.horizontal, vPadding * 2)
            .frame(minWidth: 120)
            .background(.green)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
        
    }
}

struct AppButtonView: View {

    
    var body: some View {
        Button("Withdraw") {

        }
        .buttonStyle(AppButtonStyle())
    }
}


struct AppButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AppButtonView()
    }
}
