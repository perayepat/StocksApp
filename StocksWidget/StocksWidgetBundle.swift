import WidgetKit
import SwiftUI

@main
struct StocksWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        StocksWidget()
//        StocksWidget() This is how you would add multiple widgets 
    }
}
