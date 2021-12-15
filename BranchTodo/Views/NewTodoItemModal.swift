import SwiftUI

struct NewTodoItemModal: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ListOfTodosViewModel
    @State private var itemName: String = ""
    
    let list: TodoList
    
    var body: some View {
        NavigationView {
            TextField("Enter a name", text: $itemName)
                .padding()
                .onSubmit {
                    guard !itemName.isEmpty else {
                        return
                    }
                    
                    viewModel.addNewItem(with: itemName, to: list)
                    dismiss()
                }
                .navigationTitle("New Todo Item")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add") {
                            viewModel.addNewItem(with: itemName, to: list)
                            dismiss()
                        }
                        .disabled(itemName.isEmpty)
                    }
                }
        }
    }
}

struct NewTodoItemModal_Previews: PreviewProvider {
    static var previews: some View {
        Text("Modal")
    }
}
