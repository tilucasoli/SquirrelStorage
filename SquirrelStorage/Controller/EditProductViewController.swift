//
//  EditProductViewController.swift
//  SquirrelStorage
//
//  Created by Rodrigo Matos Aguiar on 30/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class EditProductViewController: AddProductViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Editar Produto"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didSaveButtonTapped() {
        let product = getProduct()
        if let index = productIndex {
            EstoqueViewController.showedProductList[index] = product
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func configureTableView() {
        super.configureTableView()
        tableView.register(DeleteTableViewCell.self, forCellReuseIdentifier: "AddProductDelete")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        var cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductImage", for: indexPath) as! ImageTableViewCell
            if let product = product {
                cell.productImageButton.setImage(filename: product.imageFilename, placeholder: ProductStrings.placeholderName.rawValue, state: .normal)
            }
            cell.backgroundColor = .background
            cell.contentView.isUserInteractionEnabled = false
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductName", for: indexPath) as! NameTableViewCell
            if let product = product {
                cell.productNameTextField.text = product.name
            }
            cell.productNameTextField.delegate = self
            cell.backgroundColor = .background
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductCategory", for: indexPath) as! CategoryTableViewCell
            if let product = product {
                var pickerIndex = 0
                for i in 0..<categories.count where categories[i].name == product.category {
                    pickerIndex = i
                    break
                }
                categoryPicker.selectRow(pickerIndex, inComponent: 0, animated: false)
            }
            cell.productCategoryTextField.delegate = self
            cell.backgroundColor = .background
            cell.categoryPicker.delegate = self
            cell.categoryPicker.dataSource = self
            configureCategory()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductPrice", for: indexPath) as! PriceTableViewCell
            if let product = product {
                cell.productPriceTextField.text = "\(product.costPrice)"
            }
            cell.productPriceTextField.delegate = self
            cell.backgroundColor = .background
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductSellPrice", for: indexPath) as! SellPriceTableViewCell
            if let product = product {
                cell.productSellPriceTextField.text = "\(product.sellPrice)"
            }
            cell.productSellPriceTextField.delegate = self
            cell.backgroundColor = .background
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductQuantity", for: indexPath) as! QuantityTableViewCell
            if let product = product {
                cell.productQuantityTextField.text = "\(product.quantity)"
            }
            cell.productQuantityTextField.delegate = self
            cell.backgroundColor = .background
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductDescription", for: indexPath) as! DescriptionTableViewCell
            if let product = product {
                cell.productDescriptionTextField.text = "\(product.description)"
            }
            cell.productDescriptionTextField.delegate = self
            cell.backgroundColor = .background
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductDelete", for: indexPath) as! DeleteTableViewCell
            cell.delegate = self
            return cell
        default:
            print("Deu erro ao carregar célula")
            return UITableViewCell()
        }
    }
    
}

extension EditProductViewController: DeleteTableViewCellDelegate {
    
    func delete() {
        if let index = productIndex {
            let alert = UIAlertController(title: "Deletar produto?", message: "Esse produto será excluído permanentemente.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Deletar", style: .destructive, handler: { _ in
                EstoqueViewController.productList.remove(at: index)
                EstoqueViewController.showedProductList = EstoqueViewController.productList
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popToRootViewController(animated: true)
            }))
            self.present(alert, animated: true)
        }
    }
    
}
