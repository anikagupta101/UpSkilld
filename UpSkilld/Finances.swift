//
//  Finances.swift
//  UpSkilld
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct Finances: View {
    @State private var incomeText: String = ""
    @State private var finance: Finance? = nil
    @State private var showBreakdown = false
    

    var body: some View {
        VStack(spacing: 20) {
            Text("Finances")
                .font(.largeTitle)
                .bold()

            TextField("Enter your income", text: $incomeText)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button("Save") {
                if let income = Double(incomeText) {
                    let newFinance = Finance(totalIncome : income)
                    newFinance.calculations()
                    finance = newFinance
                    showBreakdown = true
                } else {
                    showBreakdown = false
                }
                
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            if showBreakdown {
                VStack(spacing: 10) {
                    Text("Needs (50%): $\(finance!.needs, specifier: "%.2f")")
                    Text("Wants (30%): $\(finance!.wants, specifier: "%.2f")")
                    Text("Savings (20%): $\(finance!.savings, specifier: "%.2f")")
                }
                .font(.title2)
                .padding(.top)
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    Finances()
}
