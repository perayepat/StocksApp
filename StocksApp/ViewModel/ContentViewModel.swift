import SwiftUI
import Foundation
import Combine

final class ContentViewModel: ObservableObject{
    private var cancellables = Set<AnyCancellable>()
    private let symbol: [String] = ["AAPL", "TSLA", "IBM"]
    @Published var stockData: [StockData] = []
    init() {
        loadAllSymbols()
    }
    
    func loadAllSymbols(){
        stockData = []
        symbol.forEach { symbol in
            getStockData(for: symbol)
        }
    }
    
    func getStockData(for symbol: String){
        let url =  URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(symbol)&interval=5min&apikey=\(Keys.APIKEY)")!
        
        URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { element -> Data in /// Converted th response tuple just as data
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: StockData.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    return
                }
            } receiveValue: { [unowned self]stockData in /// Refrence cycles
                DispatchQueue.main.async { /// UI From the content view is being updated so this need to be in a dispathc queue
                    self.stockData.append(stockData)
                }
            }
            .store(in: &cancellables)

    }
    
}
