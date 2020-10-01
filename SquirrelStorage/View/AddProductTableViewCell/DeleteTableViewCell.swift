//
//  DeleteTableViewCell.swift
//  SquirrelStorage
//
//  Created by Rodrigo Matos Aguiar on 01/10/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class DeleteTableViewCell: UITableViewCell {
    
    weak var delegate: DeleteTableViewCellDelegate?
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Deletar Produto", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.backgroundColor = .background
        return button
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .background
        contentView.addSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        setupDeleteButton()
    }
    
    override func becomeFirstResponder() -> Bool {
        return self.deleteButton.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func deleteButtonPressed() {
        //print("Botão Delete pressionado")
        delegate?.delete()
    }
    
    func setupDeleteButton() {
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        deleteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
}
