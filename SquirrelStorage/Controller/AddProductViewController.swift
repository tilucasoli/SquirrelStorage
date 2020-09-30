//
//  AddProductViewController.swift
//  SquirrelStorage
//
//  Created by Lucas Fernandes on 24/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController {

    var tableView = UITableView()
    var productQuantity = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(didSaveButtonTapped))
        
        view.backgroundColor = .background
        title = "Adicionar Produto"
        navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        configureTableView()
    }
    
    @objc func didSaveButtonTapped() {
        let product = getProduct()
        EstoqueViewController.productList.append(product)
        navigationController?.popViewController(animated: true)
    }
    
    func getProduct() -> Product {
        var product = Product(name: "", image: nil, quantity: 0, favorited: false, costPrice: 0, sellPrice: 0, description: "", category: "")
        if let imageURL = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ImageTableViewCell).imageURL {
            product.image = imageURL
        }
        if let name = (tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! NameTableViewCell).productNameTextField.text {
            product.name = name
        }
        if let category = (tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! CategoryTableViewCell).productCategoryTextField.text {
            product.category = category
        }
        if let price = (tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as! PriceTableViewCell).productPriceTextField.text {
            product.costPrice = Decimal(string: price) ?? 0
        }
        if let quantity = (tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as! QuantityTableViewCell).productQuantityTextField.text {
            product.quantity = Int(quantity) ?? 0
        }
        if let description = (tableView.cellForRow(at: IndexPath(row: 0, section: 5)) as! DescriptionTableViewCell).productDescriptionTextField.text {
            product.description = description
        }
        return product
    }
    
    func configureTableView() {
        
        tableView.backgroundColor = .background
        tableView.sectionFooterHeight = 35
        view.addSubview(tableView)
        setTableViewDelegates()
        
        tableView.separatorStyle = .none
        
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "AddProductImage")
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: "AddProductName")
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "AddProductCategory")
        tableView.register(PriceTableViewCell.self, forCellReuseIdentifier: "AddProductPrice")
        tableView.register(QuantityTableViewCell.self, forCellReuseIdentifier: "AddProductQuantity")
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: "AddProductDescription")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension AddProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        var cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductImage", for: indexPath) as! ImageTableViewCell
            cell.backgroundColor = .background
            cell.contentView.isUserInteractionEnabled = false
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductName", for: indexPath) as! NameTableViewCell
            cell.productNameTextField.delegate = self
            cell.backgroundColor = .background
            cell.contentView.isUserInteractionEnabled = false
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductCategory", for: indexPath) as! CategoryTableViewCell
            cell.productCategoryTextField.delegate = self
            cell.backgroundColor = .background
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductPrice", for: indexPath) as! PriceTableViewCell
            cell.productPriceTextField.delegate = self
            cell.backgroundColor = .background
            cell.contentView.isUserInteractionEnabled = false
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductQuantity", for: indexPath) as! QuantityTableViewCell
            //cell.productQuantityTextField.delegate = self
            cell.backgroundColor = .background
            cell.contentView.isUserInteractionEnabled = false
            cell.bringSubviewToFront(cell.increaseQuantityButton)
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddProductDescription", for: indexPath) as! DescriptionTableViewCell
            cell.productDescriptionTextField.delegate = self
            cell.backgroundColor = .background
            cell.contentView.isUserInteractionEnabled = false
            return cell
        default:
            print("error, cabo")
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 150 : 31
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if (cell?.canBecomeFirstResponder != nil) {
                cell?.becomeFirstResponder()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .background
        
        return view
    }
}

extension AddProductViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddProductViewController: QuantityAddProductDelegate {
    
    func increaseQuantity(label: UILabel) {
        productQuantity += 1
        label.text = "\(productQuantity)"
    }
    
    func decreaseQuantity(label: UILabel) {
        if productQuantity > 0 {
            productQuantity -= 1
        }
        label.text = "\(productQuantity)"
    }
}

extension AddProductViewController: imagePickerDelegate {
    func presentImagePicker(imgPickerController: UIImagePickerController) {
        present(imgPickerController, animated: true, completion: nil)
    }

}
