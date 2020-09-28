//
//  QuantityTableViewCell.swift
//  SquirrelStorage
//
//  Created by Lucas Fernandes on 28/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class QuantityTableViewCell: UITableViewCell {
    
    weak var delegate: QuantityAddProductDelegate?

    let productQuantityTextField: UILabel = {
        let textField = UILabel()
        textField.text = "Quantidade"
        
        return textField
    }()
    
    let currentQuantity: UILabel = {
        let currentQuantity = UILabel()
        currentQuantity.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        currentQuantity.textColor = .purpleSS
        currentQuantity.text = "0"
        return currentQuantity
    }()
    
    let increaseQuantityButton: UIButton = {
        let increaseQuantityButton = UIButton()
        let font = UIFont.boldSystemFont(ofSize: 20)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.background
        ]
        let title = NSAttributedString(string: "+", attributes: attributes)
        increaseQuantityButton.setAttributedTitle(title, for: .normal)
        increaseQuantityButton.backgroundColor = .purpleSS
        increaseQuantityButton.layer.cornerRadius = 4
        increaseQuantityButton.addTarget(self, action: #selector(increaseQuantityButtonPressed), for: .touchUpInside)
        increaseQuantityButton.addTarget(self, action: #selector(quantityButtonDown(sender:)), for: .touchDown)
        return increaseQuantityButton
    }()
    
    let decreaseQuantityButton: UIButton = {
        let decreaseQuantityButton = UIButton()
        let font = UIFont.boldSystemFont(ofSize: 20)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.background
        ]
        let title = NSAttributedString(string: "-", attributes: attributes)
        decreaseQuantityButton.setAttributedTitle(title, for: .normal)
        decreaseQuantityButton.backgroundColor = .purpleSS
        decreaseQuantityButton.layer.cornerRadius = 4
        decreaseQuantityButton.addTarget(self, action: #selector(decreaseQuantityButtonPressed), for: .touchUpInside)
        decreaseQuantityButton.addTarget(self, action: #selector(quantityButtonDown(sender:)), for: .touchDown)
        return decreaseQuantityButton
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(productQuantityTextField)
        
        setProductQuantityConstraints()
        setupIncreaseQuantityButton()
        setupCurrentQuantity()
        setupDecreaseQuantityButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func increaseQuantityButtonPressed() {
        increaseQuantityButton.backgroundColor = .background
        delegate?.increaseQuantity(label: currentQuantity)
        print("apertou")
    }
    
    @objc func decreaseQuantityButtonPressed() {
        decreaseQuantityButton.backgroundColor = .background
        delegate?.decreaseQuantity(label: currentQuantity)
        print("apertou")
    }
    
    @objc func quantityButtonDown(sender: UIButton) {
        sender.backgroundColor = .lightGray
    }
    
    func setupCurrentQuantity() {
        addSubview(currentQuantity)
        currentQuantity.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentQuantity.trailingAnchor.constraint(equalTo: increaseQuantityButton.leadingAnchor, constant: -24),
            currentQuantity.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupIncreaseQuantityButton() {
        addSubview(increaseQuantityButton)
        increaseQuantityButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            increaseQuantityButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            increaseQuantityButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            increaseQuantityButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            increaseQuantityButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8)
        ])
    }
    
    func setupDecreaseQuantityButton() {
        addSubview(decreaseQuantityButton)
        decreaseQuantityButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            decreaseQuantityButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            decreaseQuantityButton.trailingAnchor.constraint(equalTo: currentQuantity.leadingAnchor, constant: -4),
            decreaseQuantityButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            decreaseQuantityButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8)
        ])
    }
    
    func setProductQuantityConstraints() {
        productQuantityTextField.translatesAutoresizingMaskIntoConstraints                                     = false
        productQuantityTextField.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive                = true
        productQuantityTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive       = true
        productQuantityTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive    = true
    }

}
