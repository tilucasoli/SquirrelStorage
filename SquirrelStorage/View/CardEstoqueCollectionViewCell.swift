//
//  CardEstoqueCollectionViewCell.swift
//  SquirrelStorage
//
//  Created by Lucas Oliveira on 17/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class CardEstoqueCollectionViewCell: UICollectionViewCell {
    let total: UILabel = {
        let lbl = UILabel()
        lbl.text = "Total investido"
        lbl.font = UIFont.preferredFont(forTextStyle: .subheadline)
        lbl.textColor = UIColor.background
        return lbl
    }()
    let totalValue: UILabel = {
        let lbl = UILabel()
        lbl.text = "R$ 300,00"
        lbl.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        lbl.textColor = UIColor.background
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .purpleSS
        layer.cornerRadius = 5
        setupTotalLabel()
        setupTotalValueLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupTotalLabel() {
        addSubview(total)
        total.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            total.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            total.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupTotalValueLabel() {
        addSubview(totalValue)
        totalValue.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            totalValue.topAnchor.constraint(equalTo: total.topAnchor, constant: 20),
            totalValue.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            totalValue.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
            //totalValue.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
