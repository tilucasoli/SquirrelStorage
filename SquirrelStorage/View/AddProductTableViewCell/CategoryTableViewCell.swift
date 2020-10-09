//
//  CategoryTableViewCell.swift
//  SquirrelStorage
//
//  Created by Lucas Fernandes on 28/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//mnu

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    var content: [String] = []
    var isObserving = false
    
    class var expandedHeight: CGFloat {get { return 200}}
    class var defaultHeight: CGFloat {get {return 36}}
    
    let categoryPicker = UIPickerView()
    var pickerTitle = UILabel()
    var pickerContect = UILabel()
    var selectedPickerIndex: Int = 0

    let productCategoryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Categoria"
        
        return textField
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(productCategoryTextField)
        contentView.addSubview(categoryPicker)
        setProductCategoryConstraints()
        setCategoryPicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryPicker.selectRow(selectedPickerIndex, inComponent: 0, animated: false)
    }
    
    func setCategoryPicker() {
        
    }
    
    func checkHeight() {
        categoryPicker.isHidden = (frame.height < CategoryTableViewCell.expandedHeight)
    }
    
    func watchFrameChanges() {
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.initial], context: nil)
            isObserving = true
        }
    }
    
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setProductCategoryConstraints() {
        productCategoryTextField.translatesAutoresizingMaskIntoConstraints                                  = false
        productCategoryTextField.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive             = true
        productCategoryTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive    = true
        productCategoryTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        categoryPicker.translatesAutoresizingMaskIntoConstraints = false
        categoryPicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -8).isActive = true
        categoryPicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive    = true
        categoryPicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        categoryPicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
}
