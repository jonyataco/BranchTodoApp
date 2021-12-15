import SwiftUI

/// Cell for a Todo List
struct TodoListCell: View {
    // Normally I would want to pass in properties rather the object instance,
    // For example I would ideally want to pass in a
    // let name: String
    // let description: String?
    // but I need to use an observed object so that model updates from detail views cause a redraw of this view
    // In particular, this is important so that the number of todos is updated when a user goes into the detail screen and
    // marks a todo as completed.
    @ObservedObject var list: TodoList
    
    let systemImageName: String
    let systemImageColor: Color
    
    var body: some View {
        HStack {
            // Because this initializer uses system images,
            // if the provided string does not match a system image then it will not render any image
            Image(systemName: systemImageName)
                .foregroundColor(systemImageColor)
            
            VStack(alignment: .leading) {
                Text(list.unwrappedName)
                    .font(.headline)
            
                if let description = list.listDescription {
                    Text(description)
                        .font(.subheadline)
                        .italic()
                }
            }
            
            Spacer()
            
            Text("\(list.numTodoItems) todos")
                .font(.body)
                .bold()
        }
    }
}

struct TodoListCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                List {
                    
                }
                .navigationTitle("TodoList Cells")
            }
        }
    }
}
