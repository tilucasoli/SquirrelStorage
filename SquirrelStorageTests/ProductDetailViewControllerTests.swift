//
//  ProductDetailViewControllerTests.swift
//  SquirrelStorageTests
//
//  Created by Lucas Oliveira on 28/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import XCTest
@testable import SquirrelStorage

class ProductDetailViewControllerTests: XCTestCase {

    func test_increaseQuantity_returns_2Unidades() {
        let viewCon = ProductDetailViewController()

        let productDetailsView = ProductDetailView()
        
        viewCon.productDetailView = productDetailsView
        
        // if
        let product = Product(name: "Teste", image: nil, quantity: 1, favorited: true, costPrice: 10, sellPrice: 11, description: "Teste phrase", category: "Teste")
        viewCon.product = product
        viewCon.increaseQuantity()
        XCTAssertEqual("2 unidades", viewCon.productDetailView!.currentQuantity.text)
        
    }
    
    func test_increaseQuantity_returns_1Unidade() {
        let viewCon = ProductDetailViewController()

        let productDetailsView = ProductDetailView()
        
        viewCon.productDetailView = productDetailsView
        
        // else
        let product = Product(name: "Teste", image: nil, quantity: 0, favorited: true, costPrice: 10, sellPrice: 11, description: "Teste phrase", category: "Teste")
        viewCon.product = product
        viewCon.increaseQuantity()
        XCTAssertEqual("1 unidade", viewCon.productDetailView!.currentQuantity.text)
        
    }
    
    func test_decreaseQuantity_0Unidade() {
        let viewCon = ProductDetailViewController()
        
        let productDetailsView = ProductDetailView()
        
        viewCon.productDetailView = productDetailsView
        
        let product = Product(name: "Teste", image: nil, quantity: 1, favorited: true, costPrice: 10, sellPrice: 11, description: "Teste phrase", category: "Teste")
        
        viewCon.product = product
        viewCon.decreaseQuantity()
        
        XCTAssertEqual(product.quantity-1, viewCon.product?.quantity)
        XCTAssertEqual(viewCon.productDetailView.currentQuantity.text, "0 unidade")
    }
    
    func test_decreaseQuantity_1Unidades() {
        let viewCon = ProductDetailViewController()
        
        let productDetailsView = ProductDetailView()
        
        viewCon.productDetailView = productDetailsView
        
        let product = Product(name: "Teste", image: nil, quantity: 3, favorited: true, costPrice: 10, sellPrice: 11, description: "Teste phrase", category: "Teste")
        
        viewCon.product = product
        viewCon.decreaseQuantity()
        
        XCTAssertEqual(viewCon.productDetailView.currentQuantity.text, "2 unidades")
    }
    
}
