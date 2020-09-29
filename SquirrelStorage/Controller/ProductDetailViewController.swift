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
        if let productIndex = self.productIndex, needsUpdate {
            Database(filename: Database.Filename.product.rawValue).updateItem(self.product, at: productIndex)
            needsUpdate = false
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
            productDetailView.starButton.isSelected = product.favorited
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
