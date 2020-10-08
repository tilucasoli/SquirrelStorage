//
//  AgruparFiltroCollectionViewCell.swift
//  SquirrelStorage
//
//  Created by David Augusto on 28/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class AgruparFiltroCollectionViewCell: UICollectionViewCell {
    
    var active: Bool = false {
        didSet {
            if active {
                backgroundColor = .purpleSS
                titleLabel.textColor = .background
                iconImage.tintColorTo(color: .background)
                
            } else {
                backgroundColor = UIColor.purpleSS.withAlphaComponent(0.2)
                titleLabel.textColor = .largeTitle
                iconImage.tintColorTo(color: .largeTitle)
            }
        }
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .largeTitle
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.text = "-"
        return label
    }()
    
    let iconImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "Dolar")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.purpleSS.withAlphaComponent(0.2)
        layer.cornerRadius = 8
        setupIconImage()
        setupTitleLabel()
    }
    
    func configureCell(title: String, icon: String?, active: Bool) {
        titleLabel.text = title
        self.active = active
        guard let image = icon else {
            iconImage.image = nil
            remove()
            return
        }
        iconImage.image = UIImage(named: image)
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -4)
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
    func remove() {
        iconImage.removeFromSuperview()
        titleLabel.textAlignment = .center
        titleLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor).isActive = false
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
