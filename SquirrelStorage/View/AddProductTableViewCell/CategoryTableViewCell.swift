//
//  CategoryTableViewCell.swift
//  SquirrelStorage
//
//  Created by Lucas Fernandes on 28/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    var content : [String] = []
    var pickerView = UIPickerView()

    let productCategoryTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 100, width: 383, height: 40))
        textField.placeholder = "Categoria"
        
        return textField
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(productCategoryTextField)
        setProductCategoryConstraints()
//        setupLine()
        
//        backgroundColor = .purpleSS
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProductCategoryConstraints() {
        productCategoryTextField.translatesAutoresizingMaskIntoConstraints                                     = false
        productCategoryTextField.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive                = true
        productCategoryTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive       = true
        productCategoryTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive    = true
    }
    
}



extension CategoryTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return content.count
    }
    
    
}
