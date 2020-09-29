//
//  AgruparFiltroCollectionViewCell.swift
//  SquirrelStorage
//
//  Created by David Augusto on 28/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class AgruparFiltroCollectionViewCell: UICollectionViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .largeTitle
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.text = "Preço"
        return label
    }()
    
    let iconImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        image.image = nil
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.purpleSS.withAlphaComponent(0.2)
        layer.cornerRadius = 8
        setupIconImage()
        setupTitleLabel()
        
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerConstraint = titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        let leftConstraint = titleLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 8)
        if iconImage.image == nil {
            centerConstraint.isActive = true
            leftConstraint.isActive = false
        } else {
            centerConstraint.isActive = false
            leftConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupIconImage() {
        addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            iconImage.heightAnchor.constraint(equalToConstant: 22),
            iconImage.widthAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
