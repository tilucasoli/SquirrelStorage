//
//  PriceTableViewCell.swift
//  SquirrelStorage
//
//  Created by Lucas Fernandes on 28/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class PriceTableViewCell: UITableViewCell {
    
    let productCostPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Preço de custo"
        
        return label
    }()
    
    let productPriceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ex: 24,99"
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.keyboardType = .decimalPad
        textField.underlined()
        
        return textField
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(productCostPriceLabel)
        contentView.addSubview(productPriceTextField)
        setProductPriceConstraints()
    }
    
    override func becomeFirstResponder() -> Bool {
        return self.productPriceTextField.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProductPriceConstraints() {
        productCostPriceLabel.translatesAutoresizingMaskIntoConstraints                                     = false
        productCostPriceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive                = true
        productCostPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive       = true
        productCostPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive    = true
        
        productPriceTextField.translatesAutoresizingMaskIntoConstraints                                     = false
        productPriceTextField.topAnchor.constraint(equalTo: productCostPriceLabel.topAnchor, constant: 27.5).isActive  = true
        productPriceTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive       = true
        productPriceTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive    = true
    }
    
}
