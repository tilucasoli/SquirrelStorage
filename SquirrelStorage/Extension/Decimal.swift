//
//  DecimalMoneyFormatter.swift
//  SquirrelStorage
//
//  Created by Rodrigo Matos Aguiar on 29/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import Foundation

extension Decimal {
    
    func toMoneyRepresentation() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "BRL"
        numberFormatter.locale = Locale(identifier: "pt_BR")
        let moneyRepresentation = numberFormatter.string(from: self as NSDecimalNumber)
        return moneyRepresentation
    }
}

// Decimal Money Formatter
