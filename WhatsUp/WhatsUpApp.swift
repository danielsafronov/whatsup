//
//  WhatsUpApp.swift
//  WhatsUp
//
//  Created by Daniel Safronov on 12.11.2020.
//

import SwiftUI

@main
struct WhatsUpApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
