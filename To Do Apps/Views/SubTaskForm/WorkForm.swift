//
//  WorkForm.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 01/03/24.
//

import SwiftUI

struct WorkForm: View {
    @Binding var todo: WorkToDo?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Project's Name:")
            
            TextField("Enter Project's Name",
                                  text: Binding<String>(
                                    get: { todo?.project ?? "" },
                                    set: { todo?.project = $0 }
                                  ))
                .font(.system(size: 16))
                .padding(.horizontal)
                .frame(height: 50)
                .background(Color(.systemGray6))
                .cornerRadius(10)
        }
        
        HStack{
            Text("Hours Estimate: ")
            
            Spacer()
            
            Button(
                action: {
                    if let hoursEstimate = todo?.hoursEstimate, hoursEstimate > 0 {
                        todo?.hoursEstimate -= 1
                    }},

                label: {
                    Image(systemName: "minus.circle")
                })
            
            Text("\(todo?.hoursEstimate ?? 0) hours")

            Button(
                action:{
                    todo?.hoursEstimate += 1
                },
                label: {
                    Image(systemName: "plus.circle")
                })
        }
        
        
        VStack(alignment: .leading) {
            DatePicker(
                selection: Binding<Date>(
                                    get: { todo?.deadline ?? Date() },
                                    set: { todo?.deadline = $0 }
                                ),
                in: Date.now...,
                displayedComponents: .date,
                label: {
                    Text("Deadline:")
                })
        }
        Button {
            print(todo!)
        } label: {
            Text("text")
        }
    }
}

#Preview {
    @State var todo: WorkToDo? = WorkToDo(name: "", description: "", done: false, project: "", hoursEstimate: 0, deadline: Date())
    return Group {
        WorkForm(todo: $todo)
    }
}
