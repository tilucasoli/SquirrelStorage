//
//  NameTableViewCell.swift
//  SquirrelStorage
//
//  Created by Lucas Fernandes on 24/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    let productNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        
        return textField
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(productNameTextField)
        setProductNameConstraints()
        
        //backgroundColor = .purpleSS
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProductNameConstraints() {
        productNameTextField.translatesAutoresizingMaskIntoConstraints                                             = false
        productNameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive                        = true
        productNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive               = true
        productNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive            = true
    }
    
    
}
