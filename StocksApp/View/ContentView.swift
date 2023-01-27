import SwiftUI
import CoreData

struct ContentView: View {
 @ObservedObject private var model = ContentViewModel()
    
    var body: some View {
        
        NavigationView {
            List{
                HStack{
                    TextField("Search for stock", text: $model.searchSymbol)
                        .textFieldStyle(.roundedBorder)
                    Button("Add", action: model.addStock)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
