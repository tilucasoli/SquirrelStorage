//
//  ProductDetailsView.swift
//  SquirrelStorage
//
//  Created by Rodrigo Matos Aguiar on 17/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class ProductDetailView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
        return imageView
    }()
    
    let detailCard: UIView = {
        let detailCard = UIView()
        detailCard.backgroundColor = .background
        detailCard.layer.cornerRadius = 32
        detailCard.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return detailCard
    }()
    
    let quantityBar: UIView = {
        let quantityBar = UIView()
        quantityBar.backgroundColor = .purpleSS
        return quantityBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupDetailCard()
        setupQuantityBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: UIScreen.main.bounds.height * 0.41)
        ])
    }
    
    func setupDetailCard() {
        addSubview(detailCard)
        detailCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailCard.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -detailCard.layer.cornerRadius),
            detailCard.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            detailCard.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            detailCard.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: UIScreen.main.bounds.height * 0.45 - detailCard.layer.cornerRadius)
        ])
    }
    
    func setupQuantityBar() {
        addSubview(quantityBar)
        quantityBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quantityBar.topAnchor.constraint(equalTo: detailCard.bottomAnchor),
            quantityBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            quantityBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            quantityBar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
