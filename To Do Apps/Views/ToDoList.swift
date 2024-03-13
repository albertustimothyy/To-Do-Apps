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
                }
                .onMove(perform: modelData.moveItem)
            }
            .listStyle(.plain)
            
            if modelData.isEditingActive, let todo = modelData.editTodo {
                switch todo.typee {
                case .general:
                    if let generalToDo = todo.base as? GeneralToDo? {
                        EditTask(type: .general, generalToDo: generalToDo)
                    }
                    
                case .shop:
                    if let shopToDo = todo.base as? ShopToDo? {
                        EditTask(type: .shop, shopToDo: shopToDo)
                    }
                    
                case .travel:
                    if let travelToDo = todo.base as? TravelToDo? {
                        EditTask(type: .travel, travelToDo: travelToDo)
                    }

                case .work:
                    if let workToDo = todo.base as? WorkToDo? {
                        EditTask(type: .work, workToDo: workToDo)
                    }

                }
            }
        }
    }
    
    
}

#Preview {
    ToDoList().environmentObject(ListViewModel())
}
