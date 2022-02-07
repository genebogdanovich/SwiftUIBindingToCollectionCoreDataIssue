//
//  ContentView.swift
//  SwiftUIBindingToCollectionCoreDataIssue
//
//  Created by Gene Bogdanovich on 7.02.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var garden: Garden
    
    var fruits: Binding<[Fruit]> {
        Binding {
            (garden.fruits as? Set<Fruit> ?? []).sorted()
        } set: {
            garden.fruits = NSSet(array: [$0])
        }
    }
    
    var body: some View {
        NavigationView {
            List(fruits) { $fruit in
                TextField("Name", text: Binding($fruit.name)!)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        let newFruit = Fruit(context: viewContext)
                        garden.addToFruits(newFruit)
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }
}

extension Fruit: Comparable {
    public static func < (lhs: Fruit, rhs: Fruit) -> Bool {
        lhs.name! < rhs.name!
    }
}
