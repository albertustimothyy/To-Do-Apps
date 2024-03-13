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
    
    @State private var isShowingDetail = false
    
    var toDo: AnyToDo
    let onEditTapped: (() -> Void)
    
    var toDosIndex: Int {
        if let index = modelData.toDos.firstIndex(where: { $0.base.id == toDo.base.id }) {
            return index
        } else {
            return 0
        }
    }
    
    var body: some View {        
        VStack  {
            
            HStack {
                CheckboxButton(toDo: toDo, isSet: $modelData.toDos[toDosIndex].base.done)
                
                Spacer()
                
                Text(toDo.typee.rawValue.capitalized)
                    .font(.caption)
                    .foregroundStyle(Color.white)
                    .padding(4.0)
                    .background(Group {
                        switch toDo.typee {
                        case .general:
                            Color.blue
                        case .shop:
                            Color.mint
                        case .travel:
                            Color.green
                        case .work:
                            Color.brown
                        }
                    })
                    .cornerRadius(8)
                    .padding(10)
                
                
                Button {
                    showAction = true
                } label: {
                    Label("Action Button", systemImage: "ellipsis")
                        .foregroundStyle(.black)
                        .labelStyle(.iconOnly)
                } .rotationEffect(.degrees(90)).confirmationDialog("Action", isPresented: $showAction) {
                    Button("Edit Task") {
                        onEditTapped()
                    }
                    .background(NavigationLink("Detail", destination: DetailTask(todo: toDo)))
                    
                    Button("Delete Task", role: .destructive) {
                        modelData.deleteItem(toDosIndex: toDosIndex)
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text(toDo.base.name)
                }
                .buttonStyle(.plain)
            }
            .padding(.vertical, 7.0)
        }
        
        
    }
}

#Preview {
    ToDoRow(toDo: ModelData().toDos[1], onEditTapped: {}).environmentObject(ListViewModel())
}
