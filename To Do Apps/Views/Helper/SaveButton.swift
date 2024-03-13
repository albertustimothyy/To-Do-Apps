//
//  SaveButton.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 06/03/24.
//

import SwiftUI


struct SaveButton: View {
    @EnvironmentObject var modelData: ListViewModel
    var action: Action
    var type: ToDoType
    var dismiss: (() -> Void)
    var generalToDo: GeneralToDo?
    var workToDo: WorkToDo?
    var travelToDo: TravelToDo?
    var shopToDo: ShopToDo?
    
    
    var body: some View {
        Button(
            action: saveButton,
            label: {
                Text("Save")
                    .textCase(.uppercase)
                    .foregroundStyle(.white)
                    .bold()
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color(.blue))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding()
            })
    }
    
    func saveButton() {
        if inputValidation() {
            switch type {
            case .general:
                switch action {
                case .add:
                    modelData.addItem(todo: generalToDo!)
                case .edit:
                    modelData.editItem(todo: generalToDo!)
                }
            case .shop:
                switch action {
                case .add:
                    modelData.addItem(todo: shopToDo!)
                case .edit:
                    modelData.editItem(todo: shopToDo!)

                }
                
            case .travel:
                switch action {
                case .add:
                    modelData.addItem(todo: travelToDo!)

                case .edit:
                    modelData.editItem(todo: travelToDo!)

                }
            case .work:
                switch action {
                case .add:
                    modelData.addItem(todo: workToDo!)
                case .edit:
                    modelData.editItem(todo: workToDo!)
                }
            }
            dismiss()
        } else {
            print("gagal")
        }
    }
    
    func inputValidation() -> Bool {
        switch type {
        case .general:
            if generalToDo?.name.count ?? 0 < 3 ||
                generalToDo?.description.count ?? 0 < 3
            {
                return false
            }
        case .shop:
            if shopToDo?.name.count ?? 0 < 3 ||
                shopToDo?.description.count ?? 0 < 3 ||
                ((shopToDo?.shoppingList) == nil)
            {
                return false
            }
        case .travel:
            if travelToDo?.name.count ?? 0 < 3 ||
                travelToDo?.description.count ?? 0 < 3 ||
                (((travelToDo?.destination.latitude) == nil) && (travelToDo?.destination.longitude) == nil) ||
                (((travelToDo?.startDate) == nil) && (travelToDo?.endDate) == nil) ||
                travelToDo?.startDate == travelToDo?.endDate
            {
                return false
            }
        case .work:
            if workToDo?.name.count ?? 0 < 3 ||
                workToDo?.description.count ?? 0 < 3 ||
                workToDo?.project.count ?? 0 < 3 ||
                workToDo?.hoursEstimate ?? 0 <= 0 ||
                workToDo?.deadline == nil
            {
                return false
                
            }
        }
        return true
    }
}



//
//#Preview {
//    SaveButton()
//}
