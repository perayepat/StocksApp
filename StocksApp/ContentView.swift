import SwiftUI
import CoreData

struct ContentView: View {
 @ObservedObject private var model = ContentViewModel()
    
    var body: some View {
        
        NavigationView {
            List{
                ForEach(0...10, id: \.self) { number in
                    HStack{
                        Text("Number \(number)")
                        
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 150, height: 50)
                        
                        VStack(alignment: .trailing){
                            Text("Value")
                            Text("Change")
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
