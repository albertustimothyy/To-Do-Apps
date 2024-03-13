//
//  DetailTask.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 04/03/24.
//

import SwiftUI

struct DetailTask: View {
    @EnvironmentObject var modelData: ListViewModel
    @State var todo: AnyToDo
    
    var toDosIndex: Int {
        if let index = modelData.toDos.firstIndex(where: { $0.base.id == todo.base.id }) {
             return index
         } else {
             return 0
         }
     }
    
    var body: some View {
        ScrollView {
            Divider().padding(.vertical, 10)
            VStack(spacing: 30) {
                HStack {
                    Text("Type:")
                        .font(.callout)
                    
                    Text("\(todo.typee.rawValue.capitalized)")
                        .font(.headline)
                        .foregroundStyle(Color.white)
                        .padding(4.0)
                        .background(Group {
                            switch todo.typee.rawValue {
                            case "general":
                                Color.blue
                            case "travel":
                                Color.green
                            case "work":
                                Color.brown
                            case "shop":
                                Color.mint
                            default:
                                Color.red
                            }
                        })
                        .cornerRadius(8)
                    
                    Spacer()
                    
                }
                
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Task Name:")
                            .font(.headline)
                        Text(todo.base.name)
                            .font(.callout)
                    }
                    Spacer()
                }
                
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Task Description:")
                            .font(.headline)
                        Text(todo.base.description)
                            .font(.callout)
                    }
                    Spacer()
                }
                
                switch todo.typee {
                case .general:
                    EmptyView()
                case .shop:
                    if let shopToDo = todo.base as? ShopToDo {ShopDetail(shopToDo: shopToDo)}
                case .travel:
                    if let travelToDo = todo.base as? TravelToDo {TravelDetail(travelToDo: travelToDo)}
                case .work:
                    if let workToDo = todo.base as? WorkToDo {WorkDetail(workToDo: workToDo)}
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Status:")
                            .font(.headline)
                        Text(todo.base.done ? "Done" : "In Progress")
                            .font(.callout)
                    }
                    Spacer()
                }
                
            }
        }.padding(.horizontal, 20).navigationTitle("Task's Detail  🔍")
    }
}

#Preview {
    NavigationStack {
        DetailTask(todo: ModelData().toDos[2]).environmentObject(ListViewModel())
    }
}
