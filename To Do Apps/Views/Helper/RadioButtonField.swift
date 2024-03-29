//
//  RadioButtonField.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 26/02/24.
//

import SwiftUI

struct RadioButtonField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isMarked:Bool
    let callback: (String)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 14,
        color: Color = Color.black,
        textSize: CGFloat = 16,
        isMarked: Bool = false,
        callback: @escaping (String)->()
        ) {
            self.id = id
            self.label = label
            self.size = size
            self.color = color
            self.textSize = textSize
            self.isMarked = isMarked
            self.callback = callback
        }
    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: self.size, height: self.size)
                Text(label)
                        .font(Font.system(size: textSize))
                Spacer()
            }.foregroundStyle(self.color)
        }.foregroundStyle(Color.white)
    }
}

//#Preview {
//    RadioButtonField(id: <#T##String#>, label: <#T##String#>, callback: <#T##(String) -> ()#>)
//}
