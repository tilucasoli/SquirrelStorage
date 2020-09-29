//
//  DescriptionTableViewCell.swift
//  SquirrelStorage
//
//  Created by Lucas Fernandes on 28/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    let productDescriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Descrição"
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.underlined()
        
        return textField
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(productDescriptionTextField)
        setProductDescriptionConstraints()
    }
    
    override func becomeFirstResponder() -> Bool {
        return self.productDescriptionTextField.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProductDescriptionConstraints() {
        productDescriptionTextField.translatesAutoresizingMaskIntoConstraints                                     = false
        productDescriptionTextField.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive                = true
        productDescriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive       = true
        productDescriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive    = true
    }

}
