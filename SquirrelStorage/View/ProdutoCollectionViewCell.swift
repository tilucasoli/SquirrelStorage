//
//  ProdutoCollectionViewCell.swift
//  SquirrelStorage
//
//  Created by Lucas Oliveira on 21/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit
import SwiftUI

class ProdutoCollectionViewCell: UICollectionViewCell {
    let image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "iphone")
        return image
    }()
    
    let productQnty: UILabel = {
        let label = UILabel()
        label.text = "2 Unidades"
        label.textColor = .darkPurpleSS
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let productName: UILabel = {
       let label = UILabel()
        label.text = "Capa iPhone 7/8"
        label.textColor = UIColor.smallText.withAlphaComponent(0.9)
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    let productPrice: UILabel = {
       let label = UILabel()
        label.text = "R$ 30,00"
        label.textColor = UIColor.smallText.withAlphaComponent(0.8)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    let starIcon = UIHostingView(rootView: StarAnimationView(), viewController: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.shadowRadius = 6
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.02
    
        setupImage()
        setupProductQnty()
        setupProductName()
        setupProductPrice()
        setupStarIcon()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage() {
        addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            image.widthAnchor.constraint(equalToConstant: 98),
            image.heightAnchor.constraint(equalToConstant: 98)
        ])
    }
    
    func setupProductQnty() {
        addSubview(productQnty)
        productQnty.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productQnty.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            productQnty.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16)
        ])
    }
    
    func setupProductName() {
        addSubview(productName)
        productName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productName.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            productName.topAnchor.constraint(equalTo: productQnty.bottomAnchor, constant: 6)
        ])
    }
    
    func setupProductPrice() {
        addSubview(productPrice)
        productPrice.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productPrice.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            productPrice.topAnchor.constraint(equalTo: productName.bottomAnchor)
        ])
    }
    func setupStarIcon() {
        addSubview(starIcon)
        starIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            starIcon.widthAnchor.constraint(equalToConstant: 24),
            starIcon.heightAnchor.constraint(equalToConstant: 24),
            starIcon.centerYAnchor.constraint(equalTo: productQnty.centerYAnchor),
            starIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: -6)
        ])
        
    }
    
}
