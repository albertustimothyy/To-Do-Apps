//
//  ShopForm.swift
//  To Do Apps
//
//  Created by Albertus Timothy on 05/03/24.
//

import SwiftUI
import Combine

struct ShopForm: View {
    @Binding var shopToDo: ShopToDo?
    @State private var shoppingItems: [ShoppingItem]
    
    init(shopToDo: Binding<ShopToDo?>) {
        _shopToDo = shopToDo
        if let list = shopToDo.wrappedValue?.shoppingList {
            _shoppingItems = State(initialValue: list)
        } else {
            _shoppingItems = State(initialValue: [])
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(shoppingItems.indices, id: \.self) { index in
                SubShopForm(item: $shoppingItems[index], onDelete: { removeItem(at: index) })
            }
            
            HStack(alignment: .center) {
                Spacer()
                Button(action: {
                    shoppingItems.append(ShoppingItem(productName: "", photo: "", budget: 0))
                }) {
                    Image(systemName: "plus.circle.fill")
                    Text("Add Product")
                }
                Spacer()
            }
            .onReceive(Just(shoppingItems)) { newShoppingItems in
                shopToDo?.shoppingList = newShoppingItems
            }
        }
    }
    func removeItem(at index: Int) {
         shoppingItems.remove(at: index)
     }
}

struct SubShopForm: View {
    @State var image: Image?
    
    @Binding var item: ShoppingItem
    var onDelete: () -> Void

    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
        
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(.secondary)
                        
                        Text("Select Image")
                            .foregroundColor(.white)
                            .bold()
                        
                        image?
                            .resizable()
                            .scaledToFit()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: 80, height: 80)
                    .onTapGesture {
                        showingImagePicker.toggle()
                    }
                }
                .onAppear() {
                    Task { @MainActor in
                        try await Task.sleep(for: .seconds(0.5))
                        decodeImage()
                    }
                }
                .onChange(of: inputImage) {
                    loadImage()
                    if let inputData = inputImage?.pngData() {
                        let strBase64 = inputData.base64EncodedString(options: .lineLength64Characters)
                        item.photo = strBase64
                    }
                }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $inputImage)
                }
                
                VStack(alignment: .leading) {
                    TextField("Enter name",
                              text: $item.productName
                    )
                    
                    HStack {
                        Text("Rp. ")
                        
                        TextField("Enter Budget",
                                  text: Binding<String>(
                                    get: { "\(item.budget)" },
                                    set: { if let newValue = Float($0) { item.budget = newValue } }
                                )
                        )
                        .keyboardType(.numberPad)
                                            }
                    
                }
                .padding(.horizontal, 20)
                
                HStack(alignment: .center) {
                    Button {
                        onDelete()
                    } label: {
                        Image(systemName: "trash.fill")
                            .imageScale(.large)
                            .foregroundStyle(.red)
                    }
                }
            }
            .padding(15)
            .background(Color(.systemGray6))
        }
    }

    func loadImage() {	
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func decodeImage() {
        let dataDecoded : Data = Data(base64Encoded: item.photo, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        image = Image(uiImage: decodedimage ??  UIImage())
    }
    
}

#Preview {
    @State var shopToDo: ShopToDo? = ShopToDo(id: "", name: "", description: "", done: false, shoppingList: [])
    
    return Group {
        ShopForm(shopToDo: $shopToDo)

    }
}
