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
    let container = Application.bootstrap.container

    var body: some Scene {
        WindowGroup {
            HomeView(model: .init(container: container))
                .environment(\.container, container)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
