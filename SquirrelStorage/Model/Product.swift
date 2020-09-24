//
//  Product.swift
//  SquirrelStorage
//
//  Created by Lucas Oliveira on 16/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

struct Product: Codable {
    let name: String
    let image: URL?
    var quantity: Int
    let favorited: Bool
    let costPrice: Decimal
    let sellPrice: Decimal
    let description: String
    let category: String
    
//    func getUIImage() -> UIImage {
//    }
}
