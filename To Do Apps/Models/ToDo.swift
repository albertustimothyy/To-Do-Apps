//
//  ToDo.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 22/02/24.
//

import Foundation

struct ToDo: Hashable, Codable, Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var description: String
    var type: String
    var done: Bool
}
