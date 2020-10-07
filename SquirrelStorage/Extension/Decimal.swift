//
//  DecimalMoneyFormatter.swift
//  SquirrelStorage
//
//  Created by Rodrigo Matos Aguiar on 29/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import Foundation

extension Decimal {
    
    var int: Int {
        return NSDecimalNumber(decimal: self).intValue
    }
    
    func toMoneyRepresentation() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "BRL"
        numberFormatter.locale = Locale(identifier: "pt_BR")
        let moneyRepresentation = numberFormatter.string(from: self as NSDecimalNumber)
        return moneyRepresentation
    }
    
    func reaisToCentavos() -> Int {
        return (self * 100).int
    }
    
    mutating func roundToTwoDecimalPlaces() -> Decimal {
        var roundedDecimal = Decimal()
        NSDecimalRound(&roundedDecimal, &self, 2, .plain)
        return roundedDecimal
    }
}

// Decimal Money Formatter
