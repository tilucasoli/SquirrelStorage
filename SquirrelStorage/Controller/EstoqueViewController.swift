//
//  EstoqueViewController.swift
//  SquirrelStorage
//
//  Created by Lucas Oliveira on 16/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class EstoqueViewController: UIViewController {
    
    var num = 0
    
    static var productList: [Product] = []
    static var showedProductList: [Product] = EstoqueViewController.productList
    
    var plusButton: UIBarButtonItem!
    
    let viewRandom = UIView(frame: .zero)
    
    let emptyState = EmptyState()
    
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
        plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushAddController))
        navigationItem.title = "Estoque"
        view.insertSubview(viewRandom, at: 0)
        setupNavController()
        setupCollectionView()
    }
    
    @objc func pushAddController() {
        navigationController?.pushViewController(AddProductViewController(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //EstoqueViewController.showedProductList = EstoqueViewController.productList
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.reloadData()
        handleEmptyState()
    }
    
    func handleEmptyState() {
        
        if EstoqueViewController.productList.count == 0 {
            setupEmptyState()
        } else {
            emptyState.removeFromSuperview()
        }
    }
    
    func setupNavController() {
        view.backgroundColor = .background
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Estoque"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.largeTitle
        ]
        navigationController?.navigationBar.tintColor = .purpleSS
        plusButton.style = .done
        navigationItem.rightBarButtonItem = plusButton
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
    
    func setupEmptyState() {
        view.addSubview(emptyState)
        emptyState.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyState.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            emptyState.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}
extension EstoqueViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : EstoqueViewController.showedProductList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! CustomSectionView
        headerView.delegate = self
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
            let investedTotal: Decimal = EstoqueViewController.showedProductList.map{$0.costPrice * Decimal($0.quantity)}.reduce(0){$0 + $1}
            cell.totalValue.text = investedTotal.toMoneyRepresentation()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Produto", for: indexPath) as! ProdutoCollectionViewCell
            cell.delegate = self
            cell.configureCell(product: EstoqueViewController.showedProductList[indexPath.row]) {
                EstoqueViewController.showedProductList[indexPath.row].favorited = $0
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            let newVC = ProductDetailViewController(productIndex: indexPath.row)
            navigationController?.pushViewController(newVC, animated: true)
        }
    }
    
}

extension EstoqueViewController: delegateFilter {
    func filterAction() {
        // navigationController?.pushViewController(FiltroViewController(), animated: true )
        
        let modalFilter = FiltroViewController()
        modalFilter.modalPresentationStyle = .fullScreen
        modalFilter.backingImage = self.navigationController?.view.asImage()
        navigationController?.present(modalFilter, animated: false, completion: nil)
        
    }
    
}

extension EstoqueViewController: ProdutoCollectionViewCellDelegate {
    func favorite(_ state: Bool, at index: Int) {
        EstoqueViewController.showedProductList[index].favorited = state
    }
}

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
