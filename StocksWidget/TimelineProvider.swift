import WidgetKit
import Intents
import Combine

class Provider: IntentTimelineProvider {
    
    //MARK: - Place holder found when your adding the widget
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(),stockData: nil)
    }

    //MARK: - This is the current version of the widget
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        createTimelineEntry(date: Date(), configuratuion: configuration, completion: completion)
    }

    //MARK: - Used to update the widget every hour or on a schedule
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        createTimeline(date: Date(), configuratuion: configuration, completion: completion)
    }
    
    
    //MARK: - Fetch the data
    var  cancellables: Set<AnyCancellable> = []
    
    func createTimelineEntry(date: Date, configuratuion: ConfigurationIntent, completion: @escaping (SimpleEntry) -> ()){
        StockService
            .getStockData(for: configuratuion.symbol ?? "IBM")
            .sink { _ in } receiveValue: { stockData in
                let entry = SimpleEntry(date: date, configuration: configuratuion, stockData: stockData)
                completion(entry)
            }
            .store(in: &cancellables)
    }
    
    func createTimeline(date: Date, configuratuion: ConfigurationIntent, completion: @escaping (Timeline<SimpleEntry>) -> ()){
        StockService
            .getStockData(for: configuratuion.symbol ?? "IBM")
            .sink { _ in } receiveValue: { stockData in
                let entry = SimpleEntry(date: date, configuration: configuratuion, stockData: stockData)
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                
                completion(timeline)
            }
            .store(in: &cancellables)
    }
}
