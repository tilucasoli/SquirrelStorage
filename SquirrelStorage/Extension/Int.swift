//
//  Int.swift
//  SquirrelStorage
//
//  Created by Rodrigo Matos Aguiar on 07/10/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import Foundation

extension Int {
    
    var decimal: Decimal {
        return Decimal(self)
    }
    
    func centavosToReais() -> Decimal {
        return self.decimal / 100
    }
    
}
