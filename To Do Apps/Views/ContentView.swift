//
//  ContentView.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 22/02/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showAddTask = false
    
    var body: some View {
        NavigationSplitView {
            ToDoList()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("To Do List App 📝")
                                .font(.title)
                                .bold()
                            
                            Spacer()
                            
                            Menu {
                                NavigationLink {
                                    AddTask(type: .general)
                                } label: {
                                    Label("General Task", systemImage: "list.bullet.clipboard")
                                }
                                
                                NavigationLink {
                                    AddTask(type: .shop)
                                } label: {
                                    Label("Shopping Task", systemImage: "storefront")
                                }
                                
                                NavigationLink {
                                    AddTask(type: .travel)
                                } label: {
                                    Label("Travelling Task", systemImage: "airplane")
                                }
                                
                                NavigationLink {
                                    AddTask(type: .work)
                                } label: {
                                    Label("Working Task", systemImage: "person")
                                }
                                
                               
                            } label: {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                    }
                }
        } detail: {
            Text("To Do List App")
        }
        
    }
}

#Preview {
    ContentView().environmentObject(ListViewModel())
}
