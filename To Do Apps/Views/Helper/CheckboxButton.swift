//
//  CheckboxButton.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 22/02/24.
//

import SwiftUI

struct CheckboxButton: View {
    var toDo: ToDo
    @Binding var isSet: Bool
    
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            HStack {
                Label("Toggle Done", systemImage: isSet ? "checkmark.square.fill" : "square").labelStyle(.iconOnly).foregroundColor(isSet ? .blue : .red)
                
                VStack(alignment: .leading) {
                    Text(toDo.name).font(.subheadline).foregroundColor(.black).strikethrough(toDo.done ? true : false)
                    Text(toDo.description).font(.caption2).foregroundColor(Color.gray).italic().strikethrough(toDo.done ? true : false)
                }
            }.buttonStyle(.plain)
        }
    }
}

#Preview {
    let toDos = ModelData().toDos
    return Group {
        CheckboxButton(toDo: toDos[1], isSet: .constant(true))
    }
                    
}
