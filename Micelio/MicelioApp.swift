//
//  MicelioApp.swift
//  Micelio
//
//  Created by Davide Aliti on 02/10/23.
//

import SwiftUI

@main
struct MicelioApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
