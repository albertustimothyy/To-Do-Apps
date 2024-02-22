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
            ToDoList().navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("To Do List App 📝").font(.title).bold()
                            
                            Spacer()
                            Menu {
                                NavigationLink {
                                    AddTask()
                                } label: {
                                    Label("General Task", systemImage: "list.bullet.clipboard")
                                }
                                
                                NavigationLink {
                                    AddTask()
                                } label: {
                                    Label("Personal Task", systemImage: "person")
                                }
                                
                                NavigationLink {
                                    AddTask()
                                } label: {
                                    Label("Shopping Task", systemImage: "storefront")
                                }
                                
                                NavigationLink {
                                    AddTask()
                                } label: {
                                    Label("Travelling Task", systemImage: "airplane")
                                }
                                
                                NavigationLink {
                                    AddTask()
                                } label: {
                                    Label("Working Task", systemImage: "person")
                                }
                                
                                NavigationLink {
                                    AddTask()
                                } label: {
                                    Label("Learning Task", systemImage: "book.closed")
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
