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
        let textField = UITextField(frame: CGRect(x: 20, y: 100, width: 383, height: 40))
        textField.placeholder = "Preço de compra"
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;

        
        return textField
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(productPriceTextField)
        setProductPriceConstraints()
        setupLine()
        
//        backgroundColor = .purpleSS
    }
    
    override func becomeFirstResponder() -> Bool {
        return self.productPriceTextField.becomeFirstResponder()
    }
    
    func setupLine() {
        
        productPriceTextField.borderStyle = .none
        
        let borderLayer = CALayer()
        borderLayer.backgroundColor = #colorLiteral(red: 0.7725490196, green: 0.7725490196, blue: 0.7921568627, alpha: 1)
        borderLayer.frame = CGRect(x: 0.0, y: productPriceTextField.frame.size.height - 9, width: productPriceTextField.frame.width, height: 1.0)

        productPriceTextField.layer.addSublayer(borderLayer)
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
