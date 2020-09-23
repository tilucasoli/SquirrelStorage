//
//  EstoqueViewController.swift
//  SquirrelStorage
//
//  Created by Lucas Oliveira on 16/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

func centralizeCellInUICollection(weightCell: CGFloat, numberOfCells: CGFloat) -> UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    let screenSize = UIScreen.main.bounds.width
    let space = (screenSize - weightCell * numberOfCells) / (numberOfCells+1)
    
    layout.sectionInset = UIEdgeInsets(top: 0, left: space, bottom: 16, right: space)
    layout.itemSize = CGSize(width: 162, height: 206)
    layout.minimumLineSpacing = space
    layout.minimumInteritemSpacing = space
    return layout
}

class EstoqueViewController: UIViewController {
    
    var num = 0
    
    let collectionView: UICollectionView = {
        let layout = centralizeCellInUICollection(weightCell: 162, numberOfCells: 2)
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .background
        collectionView.register(ProdutoCollectionViewCell.self, forCellWithReuseIdentifier: "Produto")
        collectionView.register(CardEstoqueCollectionViewCell.self, forCellWithReuseIdentifier: "EstoqueCard")
        
        collectionView.register(CustomSectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Estoque"
        setupNavController()
        setupCollectionView()
        
    }
    
    func setupNavController() {
        view.backgroundColor = .background
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Estoque"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.largeTitle
        ]
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
extension EstoqueViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath)

            headerView.frame.size.height = 55

            return headerView
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 0 ? CGSize.zero : CGSize(width: UIScreen.main.bounds.width, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: 293, height: 93)
        } else {
            return CGSize(width: 162, height: 206)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EstoqueCard", for: indexPath) as! CardEstoqueCollectionViewCell
            return cell
        } else {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Produto", for: indexPath) as! ProdutoCollectionViewCell
            return cell
        }
    }
    
}

extension EstoqueViewController: delegateFilter {
    func filterAction() {
        navigationController?.pushViewController(FiltroViewController(), animated: true )
    }
    
}
