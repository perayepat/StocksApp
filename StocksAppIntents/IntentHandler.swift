import Intents

class IntentHandler: INExtension, ConfigurationIntentHandling {
    func resolveSymbol(for intent: ConfigurationIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        
    }
    

    func resolveCustomSymbol(for intent: ConfigurationIntent, with completion: @escaping (CustomSymbolResolutionResult) -> Void) {
        
    }
    

    
    func provideCustomSymbolOptionsCollection(for intent: ConfigurationIntent, with completion: @escaping (INObjectCollection<CustomSymbol>?,Error?) -> Void ){
        
        let symbols : [CustomSymbol] = [
            CustomSymbol(identifier: "AAPL", display: "Apple", pronunciationHint: "Apple"),
            CustomSymbol(identifier: "TSLA", display: "Tesla", pronunciationHint: "Tesla")
        ]
        
        let collection = INObjectCollection(items: symbols)
        completion(collection,nil)
    }
}
