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
    
    override func loadView() {
        productDetailView = ProductDetailView()
        view = productDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Editar", style: .plain, target: self, action: nil)
        productDetailView.backgroundColor = .systemRed
        mockProduto()
        setupProductDetailView()
    }
    
    func mockProduto() {
        self.product = Product(id: 0, name: "Capa iPhone 7", image: nil, qnty: 5, costPrice: 249.99, sellPrice: 500.00, description: "essa é uma descricao muito maneira de teste opa", tag: "Capa")
    }
    
    func setupProductDetailView() {
        if let product = self.product {
            productDetailView.cardTitle.text = product.name
            productDetailView.cardCategory.text = product.tag
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.currencyCode = "BRL"
            numberFormatter.locale = Locale(identifier: "pt_BR")
            productDetailView.salePrice.text = numberFormatter.string(from: product.sellPrice as NSDecimalNumber)
            productDetailView.costPrice.text = numberFormatter.string(from: product.costPrice as NSDecimalNumber)
            productDetailView.descriptionTextView.text = product.description
            productDetailView.currentQuantity.text = "\(product.qnty) unidades"
        }
    }

}
