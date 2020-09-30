//
//  QuantityTableViewCell.swift
//  SquirrelStorage
//
//  Created by Lucas Fernandes on 28/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class QuantityTableViewCell: UITableViewCell {
    
    let productQuantityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Quantidade"
        textField.keyboardType = UIKeyboardType.numberPad
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.underlined()
        
        return textField
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(productQuantityTextField)
        setProductQuantityConstraints()
    }
    
    override func becomeFirstResponder() -> Bool {
        return self.productQuantityTextField.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProductQuantityConstraints() {
        productQuantityTextField.translatesAutoresizingMaskIntoConstraints                                     = false
        productQuantityTextField.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive                = true
        productQuantityTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive       = true
        productQuantityTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive    = true
    }

}
