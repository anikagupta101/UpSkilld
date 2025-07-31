import SwiftUI

struct Investment: Identifiable {
    let id = UUID()
    let symbol: String
    let amount: Double
    let shares: Double
    let date: Date
}

struct StockListView: View {
    @State private var investmentHistory: [Investment] = []
    @State private var stockQuotes: [String: StockQuote] = [:]
    @State private var selectedSymbol: String?
    @State private var selectedQuote: StockQuote?
    @State private var showInvestSheet = false
    @State private var investAmount: String = ""
    @State private var sharesPurchased: Double?

    let stockService = StockService()
    let stockSymbols = ["DIS", "NFLX", "AAPL", "TSLA", "AMZN", "MSFT", "GOOG", "META", "NVDA", "BABA", "INTC", "CSCO", "ADBE"]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink("Track Investments") {
                        InvestmentHistoryScreen(investments: investmentHistory, stockQuotes: stockQuotes)
                    }
                    .font(.headline)
                    .padding(.vertical, 8)
                }

                Section {
                    ForEach(stockSymbols, id: \.self) { symbol in
                        if let quote = stockQuotes[symbol] {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(symbol)
                                        .font(.headline)
                                    Text("$\(quote.c, specifier: "%.2f")")
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text(quote.dp ?? 0 >= 0 ? "+\(quote.dp!, specifier: "%.2f")%" : "\(quote.dp!, specifier: "%.2f")%")
                                        .foregroundColor((quote.dp ?? 0) >= 0 ? .green : .red)

                                    Button("Invest") {
                                        showInvestSheet = true
                                        selectedSymbol = symbol
                                        selectedQuote = quote
                                        investAmount = ""
                                        sharesPurchased = nil
                                    }
                                    .font(.caption)
                                    .buttonStyle(.borderedProminent)
                                }
                            }
                        } else {
                            Text("Loading \(symbol)...")
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Explore Stocks")
            .onAppear {
                fetchAllStocks()
            }
            .sheet(isPresented: $showInvestSheet) {
                if let symbol = selectedSymbol, let quote = selectedQuote {
                    VStack(spacing: 20) {
                        Text("Invest in \(symbol)")
                            .font(.title)
                            .bold()

                        Text("Current Price: $\(quote.c, specifier: "%.2f")")

                        TextField("Amount to invest ($)", text: $investAmount)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.horizontal)

                        if let amount = Double(investAmount), amount > 0 {
                            let shares = amount / quote.c
                            Text("You’ll get ~\(shares, specifier: "%.4f") shares")
                        }

                        Button("Confirm Purchase") {
                            if let amount = Double(investAmount), amount > 0 {
                                let shares = amount / quote.c
                                sharesPurchased = shares

                                let newInvestment = Investment(symbol: symbol, amount: amount, shares: shares, date: Date())
                                investmentHistory.append(newInvestment)
                            }
                        }
                        .buttonStyle(.borderedProminent)

                        if let shares = sharesPurchased {
                            Text("✅ You bought \(shares, specifier: "%.4f") shares!")
                                .foregroundColor(.green)
                        }

                        Spacer()
                    }
                    .padding()
                    .presentationDetents([.medium])
                }
            }
        }
    }

    func fetchAllStocks() {
        for symbol in stockSymbols {
            stockService.fetchStockQuote(symbol: symbol) { quote in
                if let quote = quote {
                    DispatchQueue.main.async {
                        stockQuotes[symbol] = quote
                    }
                }
            }
        }
    }
}

struct InvestmentHistoryScreen: View {
    let investments: [Investment]
    let stockQuotes: [String: StockQuote]  // Add this parameter

    var body: some View {
        List(investments) { investment in
            VStack(alignment: .leading, spacing: 4) {
                Text(investment.symbol)
                    .font(.headline)
                Text("Invested: $\(investment.amount, specifier: "%.2f")")
                Text("Shares: \(investment.shares, specifier: "%.4f")")
                Text("Date: \(investment.date.formatted(date: .abbreviated, time: .shortened))")
                    .font(.caption)
                    .foregroundColor(.gray)

                if let currentPrice = stockQuotes[investment.symbol]?.c {
                    let buyPrice = investment.amount / investment.shares
                    let profitLoss = (currentPrice - buyPrice) * investment.shares
                    let profitLossColor = profitLoss >= 0 ? Color.green : Color.red

                    Text("P/L: \(profitLoss >= 0 ? "+" : "")$\(profitLoss, specifier: "%.2f")")
                        .foregroundColor(profitLossColor)
                        .bold()
                } else {
                    Text("Current price unavailable")
                        .foregroundColor(.gray)
                        .italic()
                }
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Your Investments")
    }
}


#Preview {
    StockListView()
}
