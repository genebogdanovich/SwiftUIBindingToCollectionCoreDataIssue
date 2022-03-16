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
    
    @FetchRequest(
        entity: Fruit.entity(), sortDescriptors: []
    ) private var fruitResults: FetchedResults<Fruit>
    
    var allFruits: [Fruit] {
        fruitResults.map { $0 }
    }
    
    @ObservedObject var garden: Garden
    
    var fruits: Binding<[Fruit]> {
        Binding {
            allFruits
        } set: { newFruits in
            for index in 0..<newFruits.count {
                let fruit = allFruits[index]
                fruit.name = newFruits[index].name
            }
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
                        newFruit.garden = garden
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
