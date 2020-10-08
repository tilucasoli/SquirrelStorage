//
//  Product.swift
//  SquirrelStorage
//
//  Created by Lucas Oliveira on 16/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

enum ProductStrings: String {
    case filename = "products", placeholderName = "ProductPlaceholder", imageFolderName = "Product Images"
}

class Product: Codable {
    var name: String
    var imageFilename: String
    var quantity: Int
    var favorited: Bool
    var costPrice: Decimal
    var sellPrice: Decimal
    var description: String
    var category: String
    
    enum CodingKeys: CodingKey {
        case name, imageFilename, quantity, favorited, costPrice, sellPrice, description, category
    }
    
    init(name: String, imageFilename: String, quantity: Int, favorited: Bool, costPrice: Decimal, sellPrice: Decimal, description: String, category: String) {
        self.name = name
        self.imageFilename = imageFilename
        self.quantity = quantity
        self.favorited = favorited
        self.costPrice = costPrice
        self.sellPrice = sellPrice
        self.description = description
        self.category = category
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        imageFilename = try values.decode(String.self, forKey: .imageFilename)
        quantity = try values.decode(Int.self, forKey: .quantity)
        favorited = try values.decode(Bool.self, forKey: .favorited)
        costPrice = (try values.decode(Int.self, forKey: .costPrice)).centavosToReais()
        sellPrice = (try values.decode(Int.self, forKey: .sellPrice)).centavosToReais()
        description = try values.decode(String.self, forKey: .description)
        category = try values.decode(String.self, forKey: .category)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(imageFilename, forKey: .imageFilename)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(favorited, forKey: .favorited)
        try container.encode(costPrice.reaisToCentavos(), forKey: .costPrice)
        try container.encode(sellPrice.reaisToCentavos(), forKey: .sellPrice)
        try container.encode(description, forKey: .description)
        try container.encode(category, forKey: .category)
    }
}
