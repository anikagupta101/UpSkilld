//
//  Finances.swift
//  UpSkilld
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct Finances: View {
    @State private var currentBalance: Int = 0
    @State private var expenseText: String = ""
    @State private var incomeText: String = ""
    
    var body: some View {
        VStack {
            Text("Finances")
                .font(.largeTitle)
                .bold()
            Text("Current Balance: $\(currentBalance)")
                            .font(.title2)

            TextField("Add Expense", text: $expenseText)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)

            TextField("Add Income", text: $incomeText)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
            Button("Smart Check") {
                
            }
        }
    }
}

#Preview {
    Finances()
}
