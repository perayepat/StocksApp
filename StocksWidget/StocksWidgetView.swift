import SwiftUI
import WidgetKit

struct StocksWidgetEntryView : View {
    var entry: SimpleEntry

    var body: some View {
        VStack {
            Text(entry.date, style: .time)
            Text(entry.configuration.symbol ?? "No value")
            Text(entry.stockData?.latestClose ?? "-")
        }
    }
}

struct StocksWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        StocksWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(),stockData: nil))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
