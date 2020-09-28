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
//        let textField = UITextField()
        
        textField.placeholder = "Nome"
        textField.translatesAutoresizingMaskIntoConstraints = false

        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        return textField
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //productNameTextField.delegate = self
        addSubview(productNameTextField)
        setProductNameConstraints()
        
    }
    
    override func becomeFirstResponder() -> Bool {
        return self.productNameTextField.becomeFirstResponder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLine()
    }
    
    func setupLine() {
        
        productNameTextField.borderStyle = .none
        
        let borderLayer = CALayer()
        borderLayer.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.137254902, blue: 0.262745098, alpha: 1)
        borderLayer.frame = CGRect(x: 0.0, y: productNameTextField.bounds.height + 3, width: productNameTextField.bounds.width, height: 1.0)
//        borderLayer.frame = CGRect(x: 0.0, y: productNameTextField.frame.size.height - 9, width: productNameTextField.frame.width, height: 1.0)

        productNameTextField.layer.addSublayer(borderLayer)
        print(productNameTextField.frame.size)
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

//        let myTextField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00));
//
//        // Or you can position UITextField in the center of the view
//        myTextField.center = self.view.center
//
//        // Set UITextField placeholder text
//        myTextField.placeholder = "Place holder text"
//
//        // Set text to UItextField
//        myTextField.text = "UITextField example"
//
//        // Set UITextField border style
//        myTextField.borderStyle = UITextBorderStyle.line
//
//        // Set UITextField background colour
//        myTextField.backgroundColor = UIColor.white
//
//        // Set UITextField text color
//        myTextField.textColor = UIColor.blue
        
        
        // Add UITextField as a subview
//        self.view.addSubview(myTextField)
        
//        textField.font = UIFont.systemFont(ofSize: 16)
//        textField.borderStyle = UITextField.BorderStyle.roundedRect
//        textField.autocorrectionType = UITextAutocorrectionType.no
//        textField.keyboardType = UIKeyboardType.default
//        textField.returnKeyType = UIReturnKeyType.done
//        textField.clearButtonMode = UITextField.ViewMode.whileEditing
//        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
//        textField.delegate = self
//        self.view.addSubview(textField)
