import SwiftUI
import WidgetKit

struct MediumSizedWidget : View {
    var entry: SimpleEntry
    
    var body: some View{
        VStack {
            Text(entry.configuration.symbol ?? "No value")
            LineChart(values: entry.stockData?.closeValues ?? [])
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.green, .green.opacity(0)]),
                        startPoint: .top,
                        endPoint: .bottom))
                .frame(width: 150, height: 50)
        }
    }
}
