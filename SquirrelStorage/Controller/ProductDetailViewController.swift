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
        setupProductDetailView()
    }
    
    func setupProductDetailView() {
        productDetailView.cardTitle.text = "Título"
        productDetailView.cardCategory.text = "Categoria"
        productDetailView.salePrice.text = "R$1,00"
        productDetailView.costPrice.text = "R$5,00"
        //productDetailView.salePrice.text = "R$1"
        //productDetailView.costPrice.text = "R$5"
        productDetailView.descriptionTextView.text = "essa é uma descricao muito maneira de teste"
    }

}
