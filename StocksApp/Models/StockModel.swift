import Foundation

struct StockData: Codable, Identifiable {
     
    let metaData: MetaData
    let timeSeries5Min: [String: StockDataEntry]
    let id = UUID()
    
    var latestClose: String{
        timeSeries5Min.first?.value.close ?? ""
    }
    
    var closeValues: [Double]{
        let rawValues = timeSeries5Min.values.map{Double($0.close)!}
        let max = rawValues.max() ?? 0.0
        let min = rawValues.min() ?? 0.0
        
        return rawValues.map { ($0 - min * 0.95) / (max - min * 0.95)}
    }
    
    var url: URL{
        guard let url = URL(string: "stocksapp://symbol/\(metaData.symbol)") else {
            fatalError("Failed to construct url")
        }
        
        return url
    }
    
    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries5Min = "Time Series (5min)"
    }
    
    
    struct MetaData: Codable{
        let information: String
        let symbol: String
        let lastRefresshed: String
        let interval: String
        let outputSize: String
        let timeZone: String
        
        enum CodingKeys: String, CodingKey {
            case information = "1. Information"
            case symbol = "2. Symbol"
            case lastRefresshed = "3. Last Refreshed"
            case interval = "4. Interval"
            case outputSize = "5. Output Size"
            case timeZone = "6. Time Zone"
        }
    }
    
    struct StockDataEntry: Codable{
        let open: String
        let high: String
        let low: String
        let close: String
        let volume: String
        
        enum CodingKeys:String, CodingKey {
            case open = "1. open"
            case high = "2. high"
            case low = "3. low"
            case close = "4. close"
            case volume = "5. volume"
        }
    }
}

