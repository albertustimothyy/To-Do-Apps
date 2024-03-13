//
//  ListViewModel.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 25/02/24.
//

import Foundation
import CoreLocation

class ListViewModel: ObservableObject {
    @Published var toDos: [AnyToDo] = []
    @Published var isEditingActive: Bool = false
    var editTodo: AnyToDo?
    
    
    init() {
        getItems()
    }
    
    func getItems() {
        let newItems: [AnyToDo] = load("ToDoData.json")
        toDos.append(contentsOf: newItems)
    }
    
    func deleteItem(toDosIndex: Int) {
        toDos.remove(at: toDosIndex)
    }
    
    func addItem(todo: GeneralToDo) {
        let anyToDo = AnyToDo(todo, .general)
        toDos.append(anyToDo)
    }
    
    func addItem(todo: WorkToDo) {
        let anyToDo = AnyToDo(todo, .work)
        toDos.append(anyToDo)
    }
    
    
    func addItem(todo: TravelToDo) {
        let anyToDo = AnyToDo(todo, .travel)
        toDos.append(anyToDo)
    }
    
    func addItem(todo: ShopToDo) {
        let anyToDo = AnyToDo(todo, .shop)
        toDos.append(anyToDo)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        toDos.move(fromOffsets: from, toOffset: to)
    }
    
    
    func editItem(todo: WorkToDo) {
        let newToDo = AnyToDo(todo, .work)
        var toDosIndex: Int {
            if let index = toDos.firstIndex(where: { $0.base.id == newToDo.base.id }) {
                return index
            } else {
                return 0
            }
        }
        
        toDos[toDosIndex] = newToDo
    }
    func editItem(todo: GeneralToDo) {
        let newToDo = AnyToDo(todo, .general)
        var toDosIndex: Int {
            if let index = toDos.firstIndex(where: { $0.base.id == newToDo.base.id }) {
                return index
            } else {
                return 0
            }
        }
        
        toDos[toDosIndex] = newToDo
    }
    
    func editItem(todo: TravelToDo) {
        let newToDo = AnyToDo(todo, .travel)
        var toDosIndex: Int {
            if let index = toDos.firstIndex(where: { $0.base.id == newToDo.base.id }) {
                return index
            } else {
                return 0
            }
        }
        
        toDos[toDosIndex] = newToDo
    }
    
    func editItem(todo: ShopToDo) {
        let newToDo = AnyToDo(todo, .shop)
        var toDosIndex: Int {
            if let index = toDos.firstIndex(where: { $0.base.id == newToDo.base.id }) {
                return index
            } else {
                return 0
            }
        }
        
        toDos[toDosIndex] = newToDo
    }
    
    func editTodoItem(for todo: AnyToDo) {
        editTodo = todo
        isEditingActive = true
    }
}
