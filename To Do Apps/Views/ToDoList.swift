//
//  ToDoList.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 22/02/24.
//

import SwiftUI

struct ToDoList: View {
    @EnvironmentObject var modelData: ListViewModel
        
    var body: some View {
        ZStack {
            List {
                ForEach(modelData.toDos) { toDo in
                    ToDoRow(
                        toDo: toDo,
                        onEditTapped: {
                            modelData.editTodoItem(for: toDo)
                        }
                    )
                }.onMove(perform: modelData.moveItem)
            }.listStyle(.plain)
            
            if modelData.isEditingActive, let todo = modelData.editTodo {
                EditTask(todo: todo)
             
            }
        }
    }
    
    
}

#Preview {
    ToDoList().environmentObject(ListViewModel())
}
