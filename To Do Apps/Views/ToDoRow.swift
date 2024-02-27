//
//  ToDoRow.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 22/02/24.
//

import SwiftUI

struct ToDoRow: View {
    @EnvironmentObject var modelData: ListViewModel

    @State private var showAction = false
    @State var isActive: Bool = true

    var toDo: ToDo
    let onEditTapped: (() -> Void)
    
   var toDosIndex: Int {
        if let index = modelData.toDos.firstIndex(where: { $0.id == toDo.id }) {
            return index
        } else {
            return 0
        }
    }
    
    var body: some View {
        @ObservedObject var modelData = modelData

        VStack  {
         
            HStack {
                CheckboxButton(toDo: toDo, isSet: $modelData.toDos[toDosIndex].done)
                
                Spacer()
                
                Text(toDo.type)
                    .font(.caption).foregroundColor(Color.white).padding(4.0).background(Group {
                        switch toDo.type {
                        case "Personal":
                            Color.blue
                        case "Travel":
                            Color.green
                        case "Work":
                            Color.brown
                        case "Shop":
                            Color.mint
                        default:
                            Color.red
                        }
                    }).cornerRadius(8).padding(10)
                
                
                Button {
                    showAction = true
                } label: {
                    Label("Action Button", systemImage: "ellipsis")
                        .foregroundColor(.black).labelStyle(.iconOnly)
                } .rotationEffect(.degrees(90)).confirmationDialog("Action", isPresented: $showAction) {
                    Button("Edit Task") {
                        onEditTapped()
//                        isActive = true
                    }
                    Button("Delete Task", role: .destructive) {
                        modelData.deleteItem(toDosIndex: toDosIndex)
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text(toDo.name)
                }.buttonStyle(.plain)
            }
            .padding(.vertical, 7.0)
        }
        
       
    }
}

#Preview {
    ToDoRow(toDo: ModelData().toDos[1], onEditTapped: {}).environmentObject(ListViewModel())
}
