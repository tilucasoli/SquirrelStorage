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
        
        textField.placeholder = "Nome"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.underlined()
        
        return textField
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //productNameTextField.delegate = self
        contentView.addSubview(productNameTextField)
        setProductNameConstraints()
    }
    
    override func becomeFirstResponder() -> Bool {
        return self.productNameTextField.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProductNameConstraints() {
        productNameTextField.translatesAutoresizingMaskIntoConstraints                                     = false
        productNameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive                = true
        productNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive       = true
        productNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive    = true
    }
}
