//
//  AddTask.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 23/02/24.
//

import SwiftUI

struct AddTask: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var modelData: ListViewModel
    
    @State var inputName: String = ""
    @State var inputDescription: String = ""
    @State var inputType: String = "Personal"

    
    var body: some View {
        ScrollView {
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Task Name:").font(.title3)
                TextField("Enter Task Name", text: $inputName).font(.system(size: 16)).padding(.horizontal).frame(height: 50).background(Color(.systemGray6)).cornerRadius(10)
            }.padding([.leading, .bottom, .trailing], 20.0).padding(.top, 10.0)
            
            
            
            VStack(alignment: .leading) {
                Text("Description:").font(.title3)
                TextField("Enter Description", text: $inputDescription).font(.system(size: 16)).padding(.horizontal).frame(height: 50).background(Color(.systemGray6)).cornerRadius(10)
            }.padding(20)
            
            VStack(alignment: .leading) {
                        Text("Type:")
                    .font(.title3)
                RadioButtonGroups(selectedType: $inputType) { selected in
                    print("Selected type: \(selected)")
                }
            }.padding(20)
            
            
            Button(action: saveButton, label: {
                Text("Save").textCase(.uppercase).foregroundColor(.white).bold().frame(height: 50).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).background(Color(.blue)).clipShape(RoundedRectangle(cornerRadius: 15)).padding()
            })
            .padding(.top, 10.0)
        }.navigationTitle("New Task 🗒️")
    }
    
    func saveButton() {
        if inputValidation() {
            modelData.addItem(name: inputName, description: inputDescription, type: inputType)
            dismiss()
        }
    }
    
    func inputValidation() -> Bool {
        if inputName.count < 3 || inputDescription.count < 3 {
            return false
        }
        return true
    }
    
}

#Preview {
    NavigationView {
        AddTask().environmentObject(ListViewModel())
    }
}
