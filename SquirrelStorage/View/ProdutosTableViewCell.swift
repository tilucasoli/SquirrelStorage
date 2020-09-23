//
//  ProdutosTableViewCell.swift
//  SquirrelStorage
//
//  Created by Lucas Oliveira on 18/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class ProdutosTableViewCell: UITableViewCell {
    
    let collectionView: UICollectionView = {
        let layout = centralizeCellInUICollection(weightCell: 162, numberOfCells: 2)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .background
        collectionView.register(ProdutoCollectionViewCell.self, forCellWithReuseIdentifier: "Produto")
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension ProdutosTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Produto", for: indexPath) as! ProdutoCollectionViewCell
        return cell
    }
    
}

func centralizeCellInUICollection(weightCell: CGFloat, numberOfCells: CGFloat) -> UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    let screenSize = UIScreen.main.bounds.width
    let space = (screenSize - weightCell * numberOfCells) / (numberOfCells+1)
    
    layout.sectionInset = UIEdgeInsets(top: 0, left: space, bottom: 0, right: space)
    layout.itemSize = CGSize(width: 162, height: 206)
    layout.minimumLineSpacing = space
    layout.minimumInteritemSpacing = space
    return layout
}
