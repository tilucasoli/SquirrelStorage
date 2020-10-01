//
//  ProductDetailsViewController.swift
//  SquirrelStorage
//
//  Created by Rodrigo Matos Aguiar on 17/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var productDetailView: ProductDetailView! = nil
    var product: Product?
    var productIndex: Int?
    
    init(productIndex: Int) {
        super.init(nibName: nil, bundle: nil)
        self.productIndex = productIndex
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        productDetailView = ProductDetailView()
        view = productDetailView
    }

    override func viewDidLoad() {
        productDetailView.delegate = self
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Editar", style: .plain, target: self, action: #selector(editButtonPressed))
        
        productDetailView.backgroundColor = .purpleSS
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.isTranslucent = false

        navigationController?.view.backgroundColor = UIColor.background
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = productIndex {
            product = EstoqueViewController.productList[index]
            setupProductDetailView()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let product = self.product, let index = self.productIndex {
            EstoqueViewController.productList[index] = product
        }
    }
    
    @objc func editButtonPressed() {
        if let product = self.product, let index = self.productIndex {
            let editVC = EditProductViewController(of: product, at: index)
            navigationController?.pushViewController(editVC, animated: true)
        }
    }
    
    func setupProductDetailView() {
        if let product = self.product {
            productDetailView.imageView.setImage(url: product.image, placeholder: ProductStrings.placeholderName.rawValue)
            productDetailView.cardTitle.text = product.name
            productDetailView.cardCategory.text = product.category
            productDetailView.starButton.isSelected = product.favorited
            productDetailView.salePrice.text = product.sellPrice.toMoneyRepresentation()
            productDetailView.costPrice.text = product.costPrice.toMoneyRepresentation()
            productDetailView.descriptionTextView.text = product.description
            productDetailView.currentQuantity.text = "\(product.quantity) unidades"
        }
    }

}

extension ProductDetailViewController: ProductDetailViewDelegate {
    func increaseQuantity() {
        product?.quantity += 1
        if product!.quantity >= 2 {
            productDetailView.currentQuantity.text = "\(product!.quantity) unidades"
        } else {
            productDetailView.currentQuantity.text = "\(product!.quantity) unidade"
        }
    }
    
    func decreaseQuantity() {
        if product!.quantity > 0 {
            product?.quantity -= 1
        }
        if product!.quantity >= 2 {
            productDetailView.currentQuantity.text = "\(product!.quantity) unidades"
        } else {
            productDetailView.currentQuantity.text = "\(product!.quantity) unidade"
        }
    }
    
    func favorite(_ state: Bool) {
        product?.favorited = state
    }
}
