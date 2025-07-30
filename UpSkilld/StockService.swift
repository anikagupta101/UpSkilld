import Foundation

// This struct matches Finnhub's response structure
struct StockQuote: Decodable {
    let c: Double // current price
    let d: Double? // change
    let dp: Double? // percent change
    let h: Double? // high price
    let l: Double? // low price
    let o: Double? // open price
    let pc: Double? // previous close price
}

class StockService {
    private let apiKey = "d2566s9r01qns40ddss0d2566s9r01qns40ddssg"

    func fetchStockQuote(symbol: String, completion: @escaping (StockQuote?) -> Void) {
        let urlString = "https://finnhub.io/api/v1/quote?symbol=\(symbol)&token=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Network error: \(error?.localizedDescription ?? "unknown error")")
                completion(nil)
                return
            }

            do {
                let quote = try JSONDecoder().decode(StockQuote.self, from: data)
                completion(quote)
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}

