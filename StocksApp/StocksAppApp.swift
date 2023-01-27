//
//  StocksAppApp.swift
//  StocksApp
//
//  Created by Pat on 2023/01/27.
//

import SwiftUI

@main
struct StocksAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
