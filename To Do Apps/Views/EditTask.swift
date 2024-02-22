//
//  EditTask.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 26/02/24.
//

import SwiftUI

struct EditTask: View {
    @EnvironmentObject var modelData: ListViewModel
    
    @State private var offset: CGFloat = 1000
    
    var todo: ToDo
    
    @State var inputName: String
    @State var inputDescription: String
    @State var inputType: String
    
    init(todo: ToDo) {
        self.todo = todo
        _inputName = State(initialValue: todo.name)
        _inputDescription = State(initialValue: todo.description)
        _inputType = State(initialValue: todo.type)
    }
 
    var toDosIndex: Int {
         if let index = modelData.toDos.firstIndex(where: { $0.id == todo.id }) {
             return index
         } else {
             return 0
         }
     }
    
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.1)
                .onTapGesture {
                    close()
                }
            
            ScrollView {
                Text("Edit Task").font(.title2).bold().padding(.bottom, 10)
                VStack(alignment: .leading) {
                    Text("Task Name:")
                    TextField("Enter Task Name", text: $inputName).font(.system(size: 16)).padding(.horizontal).frame(height: 40).background(Color(.systemGray6)).cornerRadius(10)
                }.padding([.leading, .bottom, .trailing], 10.0).padding(.top, 10.0)
                
                
                
                VStack(alignment: .leading) {
                    Text("Description:")
                    TextField("Enter Description", text: $inputDescription).font(.system(size: 16)).padding(.horizontal).frame(height: 40).background(Color(.systemGray6)).cornerRadius(10)
                }.padding(10)
                
                VStack(alignment: .leading) {
                            Text("Type:")
                    RadioButtonGroups(selectedType: $inputType) { selected in
                        print("Selected type: \(selected)")
                    }
                }.padding(10)
                
                
                Button(action: saveButton, label: {
                    Text("Save").textCase(.uppercase).foregroundColor(.white).bold().frame(height: 50).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).background(Color(.blue)).clipShape(RoundedRectangle(cornerRadius: 25)).padding()
                })
                .padding(.top, 10.0)
            }.fixedSize(horizontal: false, vertical: true).padding().background(.white).clipShape(RoundedRectangle(cornerRadius: 20)).overlay {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            close()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title2)
                                .fontWeight(.medium)
                        }.tint(.black)
                    }
                    Spacer()
                }.padding()
            }
            .shadow(radius: 20)
            .padding(30)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                }
            }
        }
    }
    
    func saveButton() {
        if inputValidation() {
            modelData.editItem(toDosIndex: toDosIndex, name: inputName, description: inputDescription, type: inputType)
            close()
        }
    }
    
    func close() {
        modelData.isEditingActive = false
        withAnimation(.spring()) {
            offset = 1000
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
    EditTask(todo: ModelData().toDos[1]).environmentObject(ListViewModel())
}
