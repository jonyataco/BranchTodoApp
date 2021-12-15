//
//  TodoItemCell.swift
//  BranchTodo
//
//  Created by Jonathan Yataco on 12/15/21.
//

import SwiftUI

struct TodoItemCell: View {
    let completed: Bool
    let name: String
    let markAsDoneTapped: () -> ()
    
    var body: some View {
        HStack {
            if completed {
                Circle()
                    .strokeBorder(Color.gray)
                    .frame(width: 35, height: 35, alignment: .center)
                    .background(completed ? Circle().fill(Color.red) : Circle().fill(Color.red))
                
                Text(name)
                    .strikethrough()
                    .font(.headline)
            } else {
                Button(action: markAsDoneTapped) {
                    Circle()
                        .strokeBorder(Color.gray)
                        .frame(width: 35, height: 35, alignment: .center)
                }
            
                Text(name)
                    .font(.headline)
            }
            
            Spacer()
        }
    }
}

struct TodoItemCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TodoItemCell(completed: false, name: "Hello world") {
                print("Mark tapped")
            }
            TodoItemCell(completed: true, name: "Hello world") {
                print("Mark tapped")
            }
        }
    }
}
