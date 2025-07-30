import SwiftUI

struct StockListView: View {
    @State private var stockQuotes: [String: StockQuote] = [:]
    @State private var selectedSymbol: String?
    @State private var selectedQuote: StockQuote?
    @State private var showInvestSheet = false
    @State private var investAmount: String = ""
    @State private var sharesPurchased: Double?

    let stockService = StockService()
    let stockSymbols = ["DIS", "NFLX", "AAPL", "TSLA", "AMZN", "MSFT"]

    var body: some View {
        NavigationStack {
            List {
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
                                    selectedSymbol = symbol
                                    selectedQuote = quote
                                    showInvestSheet = true
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
                                sharesPurchased = amount / quote.c
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



#Preview {
    StockListView()
}
