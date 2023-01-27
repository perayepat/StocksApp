import SwiftUI
import CoreData

struct ContentView: View {
 @ObservedObject private var model = ContentViewModel()
    
    var body: some View {
        
        NavigationView {
            List{
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
                                Text("Change")
                            }
                            .frame(width: 100)
                        }
                    }
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
