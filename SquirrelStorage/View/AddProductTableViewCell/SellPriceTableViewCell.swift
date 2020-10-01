//
//  SellPriceTableViewCell.swift
//  SquirrelStorage
//
//  Created by Lucas Fernandes on 01/10/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class SellPriceTableViewCell: UITableViewCell {

    let productSellPriceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Preço de venda"
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.keyboardType = .decimalPad
        textField.underlined()
        
        return textField
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(productSellPriceTextField)
        setProductSellPriceConstraints()
    }
    
    override func becomeFirstResponder() -> Bool {
        return self.productSellPriceTextField.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProductSellPriceConstraints() {
        productSellPriceTextField.translatesAutoresizingMaskIntoConstraints                                     = false
        productSellPriceTextField.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive                = true
        productSellPriceTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive       = true
        productSellPriceTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive    = true
    }
}
