import Foundation
import CoreData

extension TodoList {
    static var listsByDateCreated: NSFetchRequest<TodoList> = {
        let request: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \TodoList.dateCreated, ascending: false)]
        return request
      }()
    
    public var unwrappedName: String {
        return name ?? "Unknown List Name"
    }
    
    /// Returns the count of all todo items that are not completed
    public var numTodoItems: Int {
        return todoItems.count
    }
    
    /// Returns all of the todo items for a list that are NOT completed
    public var todoItems: [TodoItem] {
        let set = items as? Set<TodoItem> ?? []
        let filteredSet = set.filter { $0.completed == false }
        return filteredSet.sorted { $0.dateCreated! < $1.dateCreated! }
    }
    
    /// Returns a predicate that searches for name OR listDescription property that contains the predicate string
    static public func listsThatContain(_ predicateString: String) -> NSPredicate {
        let namePredicate = NSPredicate(format: "name CONTAINS[c] %@", predicateString)
        let descriptionPredicate = NSPredicate(format: "listDescription CONTAINS[c] %@", predicateString)
        return NSCompoundPredicate(orPredicateWithSubpredicates: [namePredicate, descriptionPredicate])
    }
}
