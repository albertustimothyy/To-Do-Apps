//
//  ShopDetail.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 08/03/24.
//

import SwiftUI

struct ShopDetail: View {
    var shopToDo: ShopToDo
    @State var image: Image?
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            ForEach(shopToDo.shoppingList) { item in
                ShopDetailRow(item: item)
            }
        }
    }
}


struct ShopDetailRow: View {
    var item: ShoppingItem
    @State var image: Image?
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .fill(.secondary)
                
                image?
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 70, height: 70)
            .onAppear() {
                decodeImage()
            }
            Spacer()
            VStack (alignment: .trailing) {
                Text(item.productName).bold()
                Text("Rp. \(item.budget)")
            }
        }
    }
    
    func decodeImage() {
        let dataDecoded : Data = Data(base64Encoded: item.photo, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        image = Image(uiImage: decodedimage ??  UIImage())
    }
}
//#Preview {
//    ShopDetail()
//}
