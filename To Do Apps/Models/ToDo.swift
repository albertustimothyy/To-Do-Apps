//
//  ToDo.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 22/02/24.
//

import Foundation
import CoreLocation


enum ToDoType : String, Codable {
    case general, shop, travel, work

    var metatype: any ToDo.Type {
        switch self {
        case .general:
            return GeneralToDo.self
        case .shop:
            return ShopToDo.self
        case .travel:
            return TravelToDo.self
        case .work:
            return WorkToDo.self
        }
    }
}
protocol ToDo: Hashable, Codable, Identifiable {
    var id: String { get }
    var name: String { get set }
    var description: String { get set }
    static var type: ToDoType { get }
    var done: Bool { get set }
}

struct GeneralToDo : ToDo {
    var id: String = UUID().uuidString
    var name: String
    var description: String
    static var type = ToDoType.general
    var done: Bool
}

struct ShopToDo : ToDo {
    var id: String = UUID().uuidString
    var name: String
    var description: String
    static var type = ToDoType.shop
    var done: Bool
    
    var shoppingList: [ShoppingItem]
}

struct ShoppingItem: Codable, Hashable, Identifiable {
    var id: String = UUID().uuidString
    var productName: String
    var photo: String
    var budget: Float
}


struct TravelToDo : ToDo {
    var id: String = UUID().uuidString
    var name: String
    var description: String
    static var type = ToDoType.travel
    var done: Bool

    var destination: Coordinates

    var locationCoordinates: CLLocation {
        CLLocation(latitude: destination.latitude, longitude: destination.longitude)
    }

    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
    
    var startDate: Date
    var endDate: Date
}

struct WorkToDo : ToDo {
    var id: String = UUID().uuidString
    var name: String
    var description: String
    static var type = ToDoType.work
    var done: Bool
    
    var project: String
    var hoursEstimate: Int
    var deadline: Date
}

struct AnyToDo : Codable, Identifiable {
    var id: String {
        base.id
    }
    var typee: ToDoType
    var base: any ToDo

    init(_ base: any ToDo, _ typee: ToDoType) {
        self.base = base
        self.typee = typee
    }

    private enum CodingKeys : CodingKey {
        case type, base
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let type = try container.decode(ToDoType.self, forKey: .type)
        self.base = try type.metatype.init(from: container.superDecoder(forKey: .base))
        self.typee = type
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(type(of: base).type, forKey: .type)
        try base.encode(to: container.superEncoder(forKey: .base))
    }
}

class todoo {
    func a() {
        var apa = GeneralToDo.init(name: "te", description: "sdad", done: false)
        apa.id = "dsaa"
    }
}
