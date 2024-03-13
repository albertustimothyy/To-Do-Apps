//
//  EditTask.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 26/02/24.
//

import SwiftUI
import MapKit

enum Action {
    case add
    case edit
}


struct EditTask: View {
    @EnvironmentObject var modelData: ListViewModel
    
    @State private var offset: CGFloat = 1000
    
    var type: ToDoType
    @State var generalToDo: GeneralToDo?
    @State var workToDo: WorkToDo?
    @State var travelToDo: TravelToDo?
    @State var shopToDo: ShopToDo?
    
    
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.1)
                .onTapGesture {
                    close()
                }
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("Edit Task").font(.title2).bold().padding(.bottom, 10)
                    VStack(alignment: .leading) {
                        Text("Task Name:")
                        TextField("Enter Task Name", text:
                            Binding<String>(
                                get: {
                                    switch type {
                                    case .general:
                                        return generalToDo?.name ?? ""
                                    case .shop:
                                        return shopToDo?.name ?? ""
                                    case .travel:
                                        return travelToDo?.name ?? ""
                                    case .work:
                                        return workToDo?.name ?? ""
                                    }
                                },
                                set: { newValue in
                                    switch type {
                                    case .general:
                                        generalToDo?.name = newValue
                                    case .shop:
                                        shopToDo?.name = newValue
                                    case .travel:
                                        travelToDo?.name = newValue
                                    case .work:
                                        workToDo?.name = newValue
                                    }
                                }
                            )
                        )
                        .font(.system(size: 16))
                        .padding(.horizontal)
                        .frame(height: 40)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }

                    
                    
                    VStack(alignment: .leading) {
                        Text("Description:")
                        TextField("Enter Description", text:
                            Binding<String>(
                                get: {
                                    switch type {
                                    case .general:
                                        return generalToDo?.description ?? ""
                                    case .shop:
                                        return shopToDo?.description ?? ""
                                    case .travel:
                                        return travelToDo?.description ?? ""
                                    case .work:
                                        return workToDo?.description ?? ""
                                    }
                                },
                                set: { newValue in
                                    switch type {
                                    case .general:
                                        generalToDo?.description = newValue
                                    case .shop:
                                        shopToDo?.description = newValue
                                    case .travel:
                                        travelToDo?.description = newValue
                                    case .work:
                                        workToDo?.description = newValue
                                    }
                                }
                            )
                        )
                        .font(.system(size: 16))
                        .padding(.horizontal)
                        .frame(height: 40)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }

                    
                    switch type {
                    case .general:
                        SaveButton(action: Action.edit, type: .general, dismiss: {close()}, generalToDo: generalToDo)
                        
                    case .shop:
                        ShopForm(shopToDo: $shopToDo)
                        SaveButton(action: Action.edit, type: .shop, dismiss: {close()}, shopToDo: shopToDo)
                    case .travel:
                        TravelForm(travelToDo: $travelToDo)
                        SaveButton(action: Action.edit, type: .travel, dismiss: {close()}, travelToDo: travelToDo)
                    case .work:
                        WorkForm(todo: $workToDo)
                        SaveButton(action: Action.edit, type: .work, dismiss: { close() }, workToDo: workToDo)
                    }
                    
                    
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20)).overlay {
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
    }
    
    
    func close() {
        modelData.isEditingActive = false
        withAnimation(.spring().speed(0.5)) {
            offset = 1000
        }
    }
}

#Preview {
    let todo = ModelData().toDos[2]
    if let workToDo = todo.base as? WorkToDo? {
        return Group {
            EditTask(type: .work, workToDo: workToDo)
        }
    }
    return EmptyView()
}
