//
//  ModelData.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 22/02/24.
//

import Foundation

@Observable
class ModelData {
    var toDos: [AnyToDo] = load("ToDoData.json")
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MM-yyyy"
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
