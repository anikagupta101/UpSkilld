//
//  Finances.swift
//  UpSkilld
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI

struct Finances: View {
    @State private var incomeText: String = ""
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
                showBreakdown = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            if showBreakdown {
                VStack(spacing: 10) {
                    Text("Needs")
                    Text("Wants")
                    Text("Savings")
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
