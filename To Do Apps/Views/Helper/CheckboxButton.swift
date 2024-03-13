//
//  CheckboxButton.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 22/02/24.
//

import SwiftUI

struct CheckboxButton: View {
    var toDo: AnyToDo
    @Binding var isSet: Bool
    
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            HStack {
                Label("Toggle Done", systemImage: isSet ? "checkmark.square.fill" : "square").labelStyle(.iconOnly).foregroundStyle(isSet ? .blue : .red)
                
                VStack(alignment: .leading) {
                    Text(toDo.base.name).font(.subheadline).foregroundStyle(.black).strikethrough(toDo.base.done ? true : false)
                    Text(toDo.base.description).font(.caption2).foregroundStyle(Color.gray).italic().strikethrough(toDo.base.done ? true : false)
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
