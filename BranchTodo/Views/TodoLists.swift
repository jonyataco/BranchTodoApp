import SwiftUI
import CoreData

struct TodoLists: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: TodoList.listsByDateCreated) var todoLists: FetchedResults<TodoList>
    @StateObject private var viewModel = TodoListViewModel()
    
    @State private var showingNewListModal = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todoLists, id: \.self) { list in
                    NavigationLink(destination: ListOfTodos(list: list)) {
                        TodoListCell(
                            list: list,
                            systemImageName: "list.triangle",
                            systemImageColor: Color.blue
                        )
                    }
                }
                .onDelete { indexSet in
                    viewModel.removeList(at: indexSet, todoLists)
                }
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) { newValue in
                todoLists.nsPredicate = newValue.isEmpty ? nil : TodoList.listsThatContain(newValue)
            }
            .navigationTitle("Lists")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showingNewListModal.toggle()
                    } label: {
                        Label("Add List", systemImage: "plus.circle.fill")
                            .labelStyle(.titleAndIcon)
                    }
                }
            }
            .sheet(isPresented: $showingNewListModal) {
                
            } content: {
                NewListModal(viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TodoLists()
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            
            TodoLists()
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (3rd generation)"))
                .previewInterfaceOrientation(InterfaceOrientation.landscapeRight)
        }
    }
}
