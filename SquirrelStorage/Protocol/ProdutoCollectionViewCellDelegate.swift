//
//  ProdutoCollectionViewCellDelegate.swift
//  SquirrelStorage
//
//  Created by Rodrigo Matos Aguiar on 28/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import Foundation

protocol ProdutoCollectionViewCellDelegate: AnyObject {
    func favorite(_ state: Bool, at index: Int)
}
