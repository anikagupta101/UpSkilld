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
    @State private var showSmartCheckPopup = false

    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                //.scaledToFill()
                .ignoresSafeArea()
            VStack(spacing: 0){
                //Spacer(minLength: 0)
                Text("Finances")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
                
                    .padding(.top, titleAtTop ?  20:200)
                    .offset(y: titleAtTop ? -50 : 0)
                    .animation(.easeInOut(duration: 0.6), value: titleAtTop)
                Spacer(minLength: titleAtTop ? 20 : 50)
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
                        VStack{//(spacing: 12)
                            LabelView(title: "Needs (50%)", amount: finance.needs)
                                .offset(x: 0, y: 30)
                            //LabelView(title: "Wants (30%)", amount: finance.wants)
                            LabelView(
                                title: "Wants (30%)",
                                amount: finance.wants,
                                btnTitle: "Smart Check",
                                btnAction: {
                                    withAnimation {
                                        showSmartCheckPopup.toggle()
                                    }
                                }
                            )
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
        .sheet(isPresented: $showSmartCheckPopup) {
            SmartCheckView(isPresented: $showSmartCheckPopup)
                .presentationDetents([.medium])
                .ignoresSafeArea()
        }
    }
}

struct LabelView: View{
    let title: String
    let amount: Double
    var btnTitle: String? = nil
    var btnAction: (() -> Void)? = nil
    
    var body: some View{
        HStack {
               Text("\(title): $\(amount, specifier: "%.2f")")
                //.frame(width: 330, height: 70)
                   .font(.system(size: 22, weight: .semibold))
                   .foregroundColor(.newGreen)
                   .lineLimit(1)
                   //.minimumScaleFactor(0.7)

               Spacer()

               if let btnTitle = btnTitle, let btnAction = btnAction {
                   Button(btnTitle, action: btnAction)
                       .font(.system(size: 16, weight: .medium))
                       .padding(.horizontal, 12)
                       .padding(.vertical, 6)
                       .background(Color.blue.opacity(0.2))
                       .foregroundColor(.blue)
                       .clipShape(Capsule())
               }
           }
           .padding()
           //.frame(maxWidth: .infinity, minHeight: 70)
           .background(Color.newGreen.opacity(0.2))
           .clipShape(Capsule())
           .padding(.horizontal, 20)
           .frame(width: 430, height: 100)
       }
   }
struct SmartCheckView: View {
    @Binding var isPresented: Bool
    @State private var checkInput: String = ""
    
    var body: some View {
        ZStack{
            Image("backgroundImage")
                .resizable()
            //.scaledToFill()
                .clipped()
                .cornerRadius(20)
            VStack(spacing: 20) {
                Text("Smart Check")
                    .font(.title)
                    .bold()
                
                TextField("Enter smart check input", text: $checkInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button("Save") {
                    isPresented = false
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Spacer()
            }
            .padding()
        }
        .shadow(radius: 10)
    }
}



#Preview {
    Finances()
}
