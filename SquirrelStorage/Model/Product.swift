//
//  Product.swift
//  SquirrelStorage
//
//  Created by Lucas Oliveira on 16/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

enum ProductStrings: String {
    case filename = "products", placeholderName = "ProductPlaceholder"
}

struct Product: Codable {
    var name: String
    var image: URL?
    var quantity: Int
    var favorited: Bool
    var costPrice: Decimal
    var sellPrice: Decimal
    var description: String
    var category: String
}

class Product2: ObservableObject {
    
    let id: Int
    let name: String
    let image: URL?
    var quantity: Int
    @Published var favorited: Bool
    let costPrice: Decimal
    let sellPrice: Decimal
    let description: String
    let tag: String
    
    internal init(id: Int, name: String, image: URL?, quantity: Int, favorited: Bool, costPrice: Decimal, sellPrice: Decimal, description: String, tag: String) {
        self.id = id
        self.name = name
        self.image = image
        self.quantity = quantity
        self.favorited = favorited
        self.costPrice = costPrice
        self.sellPrice = sellPrice
        self.description = description
        self.tag = tag
    }
    
//    func getUIImage() -> UIImage {
//    }
}
