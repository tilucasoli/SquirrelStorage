//
//  String.swift
//  SquirrelStorage
//
//  Created by Rodrigo Matos Aguiar on 07/10/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import Foundation

extension String {
    
    func toDecimal() -> Decimal {
        var numberString = self
        if numberString == "" {
            numberString = "0"
        }
        let decimalNumber = NSDecimalNumber(string: numberString, locale: Locale(identifier: "pt_BR")) as Decimal
        return decimalNumber
    }
}

// String Money Formatter
