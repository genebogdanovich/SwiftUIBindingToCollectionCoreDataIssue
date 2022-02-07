//
//  Persistence.swift
//  SwiftUIBindingToCollectionCoreDataIssue
//
//  Created by Gene Bogdanovich on 7.02.22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "SwiftUIBindingToCollectionCoreDataIssue")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
