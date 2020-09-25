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
        if let productIndex = self.productIndex {
            Database(filename: Database.Filename.product.rawValue).updateItem(self.product, at: productIndex)
        }
    }
    
    func setupProductDetailView() {
        if let product = self.product {
            if let image = product.image {
                productDetailView.imageView.image = try? UIImage(data: Data(contentsOf: image)) ?? UIImage(named: "ProductPlaceholder")
            } else {
                productDetailView.imageView.image = UIImage(named: "ProductPlaceholder")
            }
            productDetailView.cardTitle.text = product.name
            productDetailView.cardCategory.text = product.category
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.currencyCode = "BRL"
            numberFormatter.locale = Locale(identifier: "pt_BR")
            productDetailView.salePrice.text = numberFormatter.string(from: product.sellPrice as NSDecimalNumber)
            productDetailView.costPrice.text = numberFormatter.string(from: product.costPrice as NSDecimalNumber)
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
    
    func favorite() {}
}
