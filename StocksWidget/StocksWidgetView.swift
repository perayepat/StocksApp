import SwiftUI
import WidgetKit

struct StocksWidgetEntryView : View {
    
    @Environment(\.widgetFamily) var family
    var entry: SimpleEntry

    var body: some View {
        switch family{
        case .systemSmall:
            Text("")
        case .systemMedium:
            VStack {
                Text(entry.configuration.customSymbol?.identifier ?? "No custom symbol selected")
                Text(entry.configuration.symbol ?? "No value")
                LineChart(values: entry.stockData?.closeValues ?? [])
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.green, .green.opacity(0)]),
                            startPoint: .top,
                            endPoint: .bottom))
                    .frame(width: 150, height: 50)
            }
            .widgetURL(entry.stockData?.url)
            // can alternativley be wrapped in a link
        default:
            Text("Not implemented")
        }
    }
}

struct StocksWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        StocksWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(),stockData: nil))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
