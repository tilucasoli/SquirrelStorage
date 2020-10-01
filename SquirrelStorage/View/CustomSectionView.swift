//
//  CustomSectionView.swift
//  SquirrelStorage
//
//  Created by Lucas Oliveira on 18/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit
protocol delegateFilter: class {
    func filterAction()
}

class CustomSectionView: UICollectionReusableView {
    
    weak var delegate: delegateFilter?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        label.textColor = .largeTitle
        label.text = "Produtos"
        return label
    }()
    
    let filterButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        btn.setTitle("Filtrar", for: .normal)
        btn.setTitleColor(.purpleSS, for: .normal)
        btn.tintColor = UIColor.purpleSS
        btn.addTarget(self, action: #selector(AddFilter), for: .touchUpInside)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        setupTitleLabel()
        setupBtn()
    }
    
    @objc func AddFilter() {
        delegate!.filterAction()
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
        ])
    }
    
    func setupBtn() {
        addSubview(filterButton)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            filterButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            filterButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            filterButton.heightAnchor.constraint(equalToConstant: 20),
            filterButton.widthAnchor.constraint(equalToConstant: 46)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
