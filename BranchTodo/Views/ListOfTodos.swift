import SwiftUI

/// View that displays a list of todos for a given list
struct ListOfTodos: View {
    @Environment(\.managedObjectContext) var viewContext
    @StateObject private var viewModel = ListOfTodosViewModel()
    @State private var searchText: String = ""
    @State private var showingNewItemModal: Bool = false
    
    @ObservedObject var list: TodoList
    @FetchRequest private var todoItems: FetchedResults<TodoItem>
    
    init(list: TodoList) {
        self.list = list
        self._todoItems = FetchRequest(fetchRequest: TodoItem.itemsForList(list))
    }
    
    public var body: some View {
        List {
            ForEach(todoItems, id: \.self) { todoItem in
                TodoItemCell(completed: todoItem.completed, name: todoItem.unwrappedName) {
                    // Need to pass the list so that we can manually send an objectWillChange call
                    viewModel.markAsCompleted(todoItem, list)
                }
            }
            .onDelete { indexSet in
                viewModel.removeItem(at: indexSet, todoItems)
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { newValue in
            todoItems.nsPredicate = newValue.isEmpty ? TodoItem.itemsForListPredicate(list) : TodoItem.itemsThatContainPredicate(newValue, list: list)
        }
        .navigationTitle(list.unwrappedName)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button {
                    withAnimation {
                        showingNewItemModal.toggle()
                    }
                } label: {
                    Label("Add new todo", systemImage: "plus.circle.fill")
                        .labelStyle(.titleAndIcon)
                }
            }
        }
        .sheet(isPresented: $showingNewItemModal) {
            
        } content: {
            NewTodoItemModal(viewModel: viewModel, list: list)
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        Text("TodoList Preview")
    }
}
