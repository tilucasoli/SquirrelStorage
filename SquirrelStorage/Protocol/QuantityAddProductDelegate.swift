//
//  QuantityAddProductDelegate.swift
//  SquirrelStorage
//
//  Created by Lucas Fernandes on 28/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

protocol QuantityAddProductDelegate: AnyObject {
    func increaseQuantity(label: UILabel)
    func decreaseQuantity(label: UILabel)
}
