import SwiftUI

struct StockListView: View {
    @State private var stockQuotes: [String: StockQuote] = [:]
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
                            Text(quote.dp ?? 0 >= 0 ? "+\(quote.dp!, specifier: "%.2f")%" : "\(quote.dp!, specifier: "%.2f")%")
                                .foregroundColor((quote.dp ?? 0) >= 0 ? .green : .red)
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

