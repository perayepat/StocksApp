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
            MediumSizedWidget(entry: entry)
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
