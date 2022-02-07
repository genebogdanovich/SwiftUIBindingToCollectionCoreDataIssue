//
//  SwiftUIBindingToCollectionCoreDataIssueApp.swift
//  SwiftUIBindingToCollectionCoreDataIssue
//
//  Created by Gene Bogdanovich on 7.02.22.
//

import SwiftUI

@main
struct SwiftUIBindingToCollectionCoreDataIssueApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(garden: .init(context: persistenceController.container.viewContext))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
