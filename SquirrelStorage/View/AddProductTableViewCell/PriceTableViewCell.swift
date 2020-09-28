//
//  PriceTableViewCell.swift
//  SquirrelStorage
//
//  Created by Lucas Fernandes on 28/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class PriceTableViewCell: UITableViewCell {

    let productPriceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Cost Price"
        
        return textField
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(productPriceTextField)
        setProductPriceConstraints()
        
//        backgroundColor = .purpleSS
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProductPriceConstraints() {
        productPriceTextField.translatesAutoresizingMaskIntoConstraints                                     = false
        productPriceTextField.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive                = true
        productPriceTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive       = true
        productPriceTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive    = true
    }

}
