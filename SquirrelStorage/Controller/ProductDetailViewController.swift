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
    var needsUpdate = false
    
    init(of product: Product, at index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.product = product
        self.productIndex = index
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Editar", style: .plain, target: self, action: nil)
        
        productDetailView.backgroundColor = .purpleSS
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.isTranslucent = false

        navigationController?.view.backgroundColor = UIColor.background
        setupProductDetailView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let product = self.product, let index = self.productIndex {
            EstoqueViewController.productList[index] = product
        }
    }
    
    func setupProductDetailView() {
        if let product = self.product {
            productDetailView.imageView.image = UIImage(named: "ProductPlaceholder")
            if let imageURL = product.image {
                ImageFetcher().fetchImage(from: imageURL) { image in
                    DispatchQueue.main.async {
                        self.productDetailView.imageView.image = image
                    }
                }
            }
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
        needsUpdate = true
        product?.quantity += 1
        if product!.quantity >= 2 {
            productDetailView.currentQuantity.text = "\(product!.quantity) unidades"
        } else {
            productDetailView.currentQuantity.text = "\(product!.quantity) unidade"
        }
    }
    
    func decreaseQuantity() {
        needsUpdate = true
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
        needsUpdate = true
        product?.favorited = state
    }
}
