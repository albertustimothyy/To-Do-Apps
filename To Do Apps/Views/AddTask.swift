//
//  AddTask.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 23/02/24.
//

import SwiftUI
import MapKit

struct AddTask: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var modelData: ListViewModel
    
    @State var inputName: String = ""
    @State var inputDescription: String = ""
    var type: ToDoType
    
    @State var workToDo: WorkToDo? = WorkToDo(name: "", description: "", done: false, project: "", hoursEstimate: 0, deadline: Date())
    
    @State var travelToDo: TravelToDo? = TravelToDo(name: "", description: "", done: false, destination: TravelToDo.Coordinates(latitude: 0, longitude: 0), startDate: Date(), endDate: Date(timeIntervalSinceNow: 86400))
    
    @State var shopToDo: ShopToDo? = ShopToDo(id: "", name: "", description: "", done: false, shoppingList: [])
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                Divider()
                
                HStack {
                    Text("Type:")
                    Text("\(type.rawValue.capitalized)")
                        .bold()
                        .foregroundStyle(Color.white)
                        .padding(4.0)
                        .background(Group {
                            switch type {
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
                    
                    Spacer()
                    
                }
                
                VStack(alignment: .leading) {
                    Text("Task Name:")
                    
                    TextField("Enter Task Name",
                              text: $inputName)
                    .font(.system(size: 16))
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                
                VStack(alignment: .leading) {
                    Text("Description:")
                    
                    TextField("Enter Description",
                              text: $inputDescription)
                    .font(.system(size: 16))
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                
                
                VStack {
                    Spacer()
                    
                    switch type {
                    case .general:
                        let todo = GeneralToDo(name: inputName, description: inputDescription, done: false)
                        
                        SaveButton(action: Action.add, type: .general, dismiss: {dismiss()}, generalToDo: todo)
                    case .travel:
                        TravelForm(travelToDo: $travelToDo)
                            .onChange(of: inputName) { newValue, _ in
                                travelToDo?.name = newValue
                            }
                            .onChange(of: inputDescription) { newValue, _ in
                                travelToDo?.description = newValue
                            }
                        
                        SaveButton(action: Action.add, type: .travel, dismiss: {dismiss()}, travelToDo: travelToDo)
                        
                    case .work:
                        WorkForm(todo: $workToDo)
                            .onChange(of: inputName) { newValue, _ in
                                workToDo?.name = newValue
                            }
                            .onChange(of: inputDescription) { newValue, _ in
                                workToDo?.description = newValue
                            }
                        
                        SaveButton(action: Action.add, type: .work, dismiss: {dismiss()}, workToDo: workToDo)
                        
                    case .shop:
                        ShopForm(shopToDo: $shopToDo)
                            .onChange(of: inputName) { newValue, _ in
                                shopToDo?.name = newValue
                            }
                            .onChange(of: inputDescription) { newValue, _ in
                                shopToDo?.description = newValue
                            }
                        SaveButton(action: Action.add, type: .shop, dismiss: {dismiss()}, shopToDo: shopToDo)
                    }
                }
            }
        }.padding(20).navigationTitle("New Task 🗒️")
    }
}

#Preview {
    NavigationStack {
        AddTask(type: .shop).environmentObject(ListViewModel())
    }
}
