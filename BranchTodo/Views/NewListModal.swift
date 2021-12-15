import SwiftUI

struct NewListModal: View {
    enum FocusableField: Hashable {
        case listName
        case listDescription
    }
    
    @ObservedObject var viewModel: TodoListViewModel
    @Environment(\.dismiss) private var dismiss

    @FocusState private var focus: FocusableField?
    @State private var listName = ""
    @State private var listDescription = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("New List Name", text: $listName)
                    .focused($focus, equals: .listName)
                    .onSubmit {
                        focus = .listDescription
                    }
                
                TextField("Enter an optional description", text: $listDescription)
                    .focused($focus, equals: .listDescription)
                    .onSubmit {
                        if !listName.isEmpty {
                            viewModel.addList(name: listName, description: listDescription)
                            dismiss()
                        }
                    }
            }
            .navigationTitle("Create new list")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.addList(name: listName, description: listDescription)
                        dismiss()
                    }.disabled(listName.isEmpty)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct NewListModal_Previews: PreviewProvider {
    static var previews: some View {
        Text("Modal")
    }
}
