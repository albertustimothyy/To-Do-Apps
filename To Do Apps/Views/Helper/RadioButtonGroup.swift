//
//  RadioButtonGroup.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 26/02/24.
//

import SwiftUI

enum Type: String {
    case personal = "Personal"
    case work = "Work"
    case shop = "Shop"
}

struct RadioButtonGroups: View {
    @Binding var selectedType: String
    let callback: (String) -> ()
    
    init(selectedType: Binding<String>, callback: @escaping (String) -> ()) {
        self._selectedType = selectedType
        self.callback = callback
    }
    
    var body: some View {
        VStack {
            radioPersonalMajority
            Spacer()
            radioWorkMajority
            Spacer()
            radioShopMajority
        }
    }
    
    var radioPersonalMajority: some View {
        RadioButtonField(
            id: Type.personal.rawValue,
            label: Type.personal.rawValue,
            isMarked: selectedType == Type.personal.rawValue,
            callback: radioGroupCallback
        )
    }
    
    var radioWorkMajority: some View {
        RadioButtonField(
            id: Type.work.rawValue,
            label: Type.work.rawValue,
            isMarked: selectedType == Type.work.rawValue,
            callback: radioGroupCallback
        )
    }
    
    var radioShopMajority: some View {
        RadioButtonField(
            id: Type.shop.rawValue,
            label: Type.shop.rawValue,
            isMarked: selectedType == Type.shop.rawValue,
            callback: radioGroupCallback
        )
    }
    
    func radioGroupCallback(id: String) {
        selectedType = id
        callback(id)
    }
}
