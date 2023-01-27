import SwiftUI
import Foundation
import Combine

final class ContentViewModel: ObservableObject {
    
    private let context = PersistenceController.shared.container.viewContext
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var stockData: [StockData] = []
    @Published var searchSymbol = ""
    @Published var stockEntities : [StockEntity] = []
    
    init() {
        loadFromCoreData()
        loadAllSymbols()
    }
    
    func loadAllSymbols(){
        stockData = []
        stockEntities.forEach { stockEntity in
            getStockData(for: stockEntity.symbol ?? "")
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

//MARK: - Core Data Functions
extension ContentViewModel{
    
    func loadFromCoreData(){
        do {
            stockEntities = try context.fetch(StockEntity.fetchRequest())
        } catch {
            print(error)
        }
    }
    
    func addStock(){
        let newStock = StockEntity(context: context)
        newStock.symbol = searchSymbol
        
        do{
            try context.save()
        } catch {
            print(error)
        }
        
        getStockData(for: searchSymbol)
        searchSymbol = ""
    }
    
}
