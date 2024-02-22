//
//  To_Do_AppsApp.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 22/02/24.
//

import SwiftUI

@main
struct To_Do_AppsApp: App {
    @StateObject var modelData: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(modelData)
        }
    }
}
