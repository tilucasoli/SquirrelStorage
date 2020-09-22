//
//  ProductDetailViewDelegate.swift
//  SquirrelStorage
//
//  Created by Rodrigo Matos Aguiar on 22/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import Foundation

protocol ProductDetailViewDelegate: AnyObject {
    func increaseQuantity()
    func decreaseQuantity()
    func favorite()
}
