import SwiftUI
import CoreData

struct ContentView: View {
 @ObservedObject private var model = ContentViewModel()
    @State var symbol = ""
    
    var body: some View {
        
        NavigationView {
            List{
                Text(symbol)
                HStack{
                    TextField("Search for stock", text: $model.searchSymbol)
                        .textFieldStyle(.roundedBorder)
                    Button("Add", action: model.addStock)
                        .disabled(!model.symbolValid)
                }
                if !model.stockData.isEmpty{
                    ForEach(model.stockData) { stock in
                        HStack{
                            Text(stock.metaData.symbol)
                            
                            Spacer()
                            
                            LineChart(values: stock.closeValues)
                                .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.green, .green.opacity(0)]),
                                    startPoint: .top,
                                    endPoint: .bottom))
                                .frame(width: 150, height: 50)
                            
                            VStack(alignment: .trailing){
                                Text(stock.latestClose)
                            }
                            .frame(width: 100)
                        }
                    }
                    .onDelete(perform: model.delete(at:))
                }
            }
            .navigationTitle("My Stocks")
            .toolbar {
                ToolbarItem(placement: .primaryAction){
                    EditButton()
                }
            }
            .listStyle(.plain)
        }
        .onOpenURL { url in
            //allows us to work with the symbol we grabbed out the url
            guard url.scheme  == "stocksapp",
                  url.host == "symbol" else {
                return
            }
            let symbol = url.pathComponents[1]
            self.symbol = symbol
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
