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
    @State private var titleAtTop = false
    

    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                //.scaledToFill()
                .ignoresSafeArea()
                .onTapGesture {
                    hideKeyboard()
                }
            VStack{
                Spacer(minLength: 0)
                Text("Finances")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity)
                
                    .padding(.top, titleAtTop ?  40:0)
                    .offset(y: titleAtTop ? -250 : 0)
                    .animation(.easeInOut(duration: 0.6), value: titleAtTop)
                Spacer(minLength: titleAtTop ? 20 : 100)
                VStack(spacing: 20){
                    TextField("Enter your income", text: $incomeText)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .frame(width: 410, height: 40)
                    
                    Button("Save") {
                        if let income = Double(incomeText) {
                            let newFinance = Finance(totalIncome : income)
                            newFinance.calculations()
                            finance = newFinance
                            
                            withAnimation{
                                titleAtTop = true
                                showBreakdown = true
                            }
                            hideKeyboard()
                        } else {
                            withAnimation{
                                showBreakdown = false
                            }
                        }
                        
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    if showBreakdown, let finance = finance {
                        VStack(spacing: 12) {
                            LabelView(title: "Needs (50%)", amount: finance.needs)
                                .offset(x: 0, y: 30)
                            LabelView(title: "Wants (30%)", amount: finance.wants)
                                .offset(x: 0, y: 30)
                            LabelView(title: "Savings (20%)", amount: finance.savings)
                                .offset(x: 0, y: 30)
                        }
                        .transition(.opacity.combined(with: .scale))
                        .animation(.spring(), value: showBreakdown)
                        .padding(.top)
                        .font(.title2)
                        .padding(.top)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct LabelView: View{
    let title: String
    let amount: Double
    //let color: Color
    
    var body: some View{
        Text("\(title): $\(amount, specifier: "%.2f")")
            .frame(width: 330, height: 70)
            .padding()
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(.newGreen.opacity(0.2))
            .foregroundColor(.newGreen)
            .clipShape(Capsule())
            .font(.headline)
            //.frame(alignment: .leading)
    }
}


#Preview {
    Finances()
}
