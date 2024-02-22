//
//  ListViewModel.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 25/02/24.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var toDos: [ToDo] = []
    @Published var isEditingActive: Bool = false
    var editTodo: ToDo?
    
    init() {
        getItems()
    }
    
    func getItems() {
        let newItems: [ToDo] = load("ToDoData.json")
        toDos.append(contentsOf: newItems)
    }
    
    func deleteItem(toDosIndex: Int) {
        toDos.remove(at: toDosIndex)
    }
    
    func addItem(name: String, description: String, type: String) {
        let newItem = ToDo(name: name, description: description, type: type, done: false)
        toDos.append(newItem)
        
    }
    
    func moveItem(from: IndexSet, to: Int) {
        toDos.move(fromOffsets: from, toOffset: to)
    }
    
    func editItem(toDosIndex: Int, name: String, description: String, type: String) {
        toDos[toDosIndex].name = name
        toDos[toDosIndex].description = description
        toDos[toDosIndex].type = type
    }
    
    func editTodoItem(for todo: ToDo) {
        editTodo = todo
        isEditingActive = true
    }
}
