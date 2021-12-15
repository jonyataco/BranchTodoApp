import SwiftUI

class TodoListViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.container.viewContext
    
    func removeList(at offsets: IndexSet, _ todoLists: FetchedResults<TodoList>) {
        for index in offsets {
            viewContext.delete(todoLists[index])
        }
        
        PersistenceController.shared.save()
    }
    
    func addList(name: String, description: String) {
        let list = TodoList(context: viewContext)
        list.name = name
        list.listDescription = description.isEmpty ? nil : description
        list.dateCreated = Date()
        
        PersistenceController.shared.save()
    }
}
