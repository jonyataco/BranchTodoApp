import SwiftUI

@main
struct BranchTodoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TodoLists()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
