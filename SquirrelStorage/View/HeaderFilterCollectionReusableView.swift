//
//  HeaderFilterCollectionReusableView.swift
//  SquirrelStorage
//
//  Created by David Augusto on 28/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class HeaderFilterCollectionReusableView: UICollectionReusableView {
        
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .largeTitle
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = "Preço"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
        ])
    }
}
