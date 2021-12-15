import Foundation
import CoreData

extension TodoItem {
    public var unwrappedName: String {
        return name ?? "Unknown name"
    }
    
    static public func itemsThatContainPredicate(_ predicateString: String, list: TodoList) -> NSPredicate {
        let namePredicate = NSPredicate(format: "name CONTAINS[c] %@", predicateString)
        let parentListPredicate = itemsForListPredicate(list)
        return NSCompoundPredicate(andPredicateWithSubpredicates: [namePredicate, parentListPredicate, itemsNotCompletedPredicate])
    }
    
    static public func itemsForList(_ list: TodoList) -> NSFetchRequest<TodoItem> {
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \TodoItem.dateCreated, ascending: false)]
        
        let parentListPredicate = itemsForListPredicate(list)
         
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [parentListPredicate, itemsNotCompletedPredicate])
        
        return request
    }
    
    static func itemsForListPredicate(_ list: TodoList) -> NSPredicate {
        return NSPredicate(format: "parentList == %@", list)
    }
    
    static public var itemsNotCompletedPredicate: NSPredicate {
        return NSPredicate(format: "completed == %d", false)
    }
}
