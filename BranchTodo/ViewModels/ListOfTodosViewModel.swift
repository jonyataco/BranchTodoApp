import SwiftUI

class ListOfTodosViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.container.viewContext
    
    /// Adds a new todo item to the given parent list
    func addNewItem(with name: String, to list: TodoList) {
        guard !name.isEmpty else {
            print("Didn't add new todo item to \(list.unwrappedName) because the provided name was empty")
            return
        }
        
        let newTodoItem = TodoItem(context: PersistenceController.shared.container.viewContext)
        
        newTodoItem.name = name
        newTodoItem.dateCreated = Date()
        newTodoItem.parentList = list
        PersistenceController.shared.save()
    }
    
    func removeItem(at offsets: IndexSet, _ todoItem: FetchedResults<TodoItem>) {
        for index in offsets {
            viewContext.delete(todoItem[index])
        }
        
        PersistenceController.shared.save()
    }
    
    func markAsCompleted(_ item: TodoItem, _ list: TodoList) {
        withAnimation {
            item.completed = true
            list.objectWillChange.send()
            PersistenceController.shared.save()
        }
    }
}
