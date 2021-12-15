//
//  BranchTodoApp.swift
//  BranchTodo
//
//  Created by Jonathan Yataco on 12/15/21.
//

import SwiftUI

@main
struct BranchTodoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
